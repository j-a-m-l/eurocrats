require_relative 'supplier'
require_relative 'customer'

require 'forwardable'

module Eurocrat

  # Context reunites the entities that could be used for determining, among other questions, these:
  #
  # * What are the evidences of the customer location?
  # * Are they enough?
  # * What are the VAT rates that correspond to that location?
  # * How much should be charged?
  #
  # FIXME This is the unique method that could be called before having obtained enough
  # evidences of the customer location.
  # Other methods raise a `ConflictingEvidencesError` in that case because they
  # can't operate without knowing the country.
  #
  class Context
    extend Forwardable

    # TODO configurable in Eurocrat
    VIES_EVIDENCE_LABEL = 'eurocrat.vies.validation'

    attr_reader :supplier
    attr_reader :customer

    # TODO options...
    def initialize supplier=nil, customer=nil
      @evidences = {}

      # TODO default supplier
      @supplier ||= supplier ||= Eurocrat::Supplier.new
      @customer ||= customer ||= Eurocrat::Customer.new

      # TODO default rate
      @rate = 'standard'

      # TODO
      @minimum = 2
    end

    def evidences
      @evidences.merge(customer.collect_eurocrat_evidences)
    end

    def [] label
      evidences[label]
    end

    def []= label, source
      @evidences[label] = source.is_a?(Evidence) ? source : Evidence.from(source)
    end

    def only_location_evidences
      evidences.reject {|e| e == VIES_EVIDENCE_LABEL }
    end

    # This method checks only the customer location evidences
    #
    # The default strategy is to find `@minimum` evidences with the same country code
    #
    # If you need a custom strategy for deciding about them, like prioritizing
    # some evidences or ignoring others, you should be able to achieve that just
    # overriding this method in an inherited Context class
    #
    # TODO example with billing_address, ip and credit card
    # TODO example with billing_address, ip, credit card and phone
    #
    def non_conflicting_location_evidences
      return only_location_evidences if only_location_evidences.size == 1

      # by_country: { country_code => [[evidence_label, evidence_object], ...] }
      by_country = only_location_evidences.group_by {|l, e| e.country_code }

      # Gets the first country with at least 2 non conflicting evidences
      non = by_country.find {|c, es_a| es_a.size >= @minimum }

      # Converts to Hash again: { evidence_label_1 => evidence_object_1, ... }
      (non && non[1] or {}).reduce({}) {|all, e_a| all.merge(e_a[0] => e_a[1]) }
    end
    alias favorable_evidences non_conflicting_location_evidences

    # This method depends on the result of `non_conflicting_location_evidences`, so it should
    # not be necessary to override it
    def conflicting_location_evidences
    end
    alias conflicts conflicting_location_evidences

    def enough_evidences?
      unless evidences.empty?
        return (b2b? && valid_vat_numbers? or favorable_evidences.size >= @minimum)
      end

      false
    end
    alias enough? enough_evidences?

    def evidenced_country_code
      unless non_conflicting_location_evidences.size >= @minimum
        raise ConflictingEvidencesError.new 'Operation requires enough non conflicting evidences'
      end

      non_conflicting_location_evidences.values.first.country_code
    end
    alias country_code evidenced_country_code

    def country_code_of evidence_label
      evidences[evidence_label].country_code
    end

    def taxables?
      @supplier.taxable? && @customer.taxable?
    end
    alias b2b? taxables?

    # Stores automatically the VIES validation as an evidence
    def validate_on_vies!
      @evidences[VIES_EVIDENCE_LABEL] = Vies::Validation.new(@supplier, @customer).request!
    end

    # TODO If supplier or customer change their VAT this should be updated
    def valid_vat_numbers?
      return evidences[VIES_EVIDENCE_LABEL].valid? if evidences.has_key? VIES_EVIDENCE_LABEL
      nil
    end

    # If customer is in the same country than supplier, it should be charged
    # Then, the supplier must pay that collected VAT to her tax authorities,
    # although she could deduct her paid VAT
    # => true
    # => false
    # => nil
    def should_vat_be_charged?
      if b2b? && valid_vat_numbers?
         different_countries?
      elsif Country.in_european_union? evidenced_country_code
        true
      else
        false
      end
    end

    def vat_rates
      VatRates.in evidenced_country_code
    end

    def vat_rates_in country_code
      VatRates.in country_code
    end

    def vat_rates_of evidence_label
      VatRates.in country_code_of evidence_label
    end

    # TODO add the "as" method to Numeric objects
    def vat_for amount, rate=nil
      if should_vat_be_charged?
        rate ||= @rate
        amount * vat_rates[rate] / 100
      else
        0
      end
    end

    # TODO add the "as" method to Numeric objects
    def with_vat amount, rate=nil
      amount * vat_for(amount, rate)
    end

    def open &block
      instance_eval &block
    end

    private

      def different_countries?
        @supplier.vat_number.country_code != @consumer.vat_number.country_code
      end

  end

  class Eurocrat::ConflictingEvidencesError < StandardError; end

end
