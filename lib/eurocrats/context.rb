require_relative 'supplier'
require_relative 'customer'

require 'forwardable'

module Eurocrats

  ##
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

    # TODO configurable in Eurocrats
    VIES_EVIDENCE_LABEL = 'eurocrats.vies.validation'

    attr_reader :supplier
    attr_reader :customer

    # TODO options...
    def initialize supplier=nil, customer=nil
      @supplier ||= supplier ||= Eurocrats.default_supplier

      raise ArgumentError.new 'A supplier is required' unless @supplier

      unless @supplier.is_a? Eurocrats::Taxable
        raise TypeError.new 'Supplier has to include Eurocrats::Taxable'
      end

      @customer ||= customer ||= Eurocrats::Customer.new
      @evidences = {}

      # TODO default rate
      @rate = 'standard'

      # TODO
      @minimum = 2
    end

    # TODO evidences[]= like []=
    def evidences
      @evidences.merge(customer.collect_eurocrats_evidences)
    end
    alias evidence evidences

    def [] label
      evidences[label] or raise InvalidEvidenceError.new 'Evidence does not exist'
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
    # TODO
    def conflicting_location_evidences
    end
    alias conflicts conflicting_location_evidences

    # TODO
    def favorable_evidences? label_a, label_b
      not conflicting_evidences?
    end
    alias favorable? favorable_evidences?

    # TODO more than 2 evidences
    def conflicting_evidences? label_a, label_b
      evidences[label_a].country_code != evidences[label_b].country_code
    end
    alias conflicting? conflicting_evidences?

    def enough_evidences?
      unless evidences.empty?
        return (b2b? && valid_vat_numbers? or favorable_evidences.size >= @minimum)
      end

      false
    end
    alias enough? enough_evidences?

    # TODO remove, but add .code to Country
    def evidenced_country_code
      unless non_conflicting_location_evidences.size >= @minimum
        raise ConflictingEvidencesError.new 'Operation requires enough non conflicting evidences'
      end

      non_conflicting_location_evidences.values.first.country_code
    end
    alias country_code evidenced_country_code

    def evidenced_country
      Eurocrats.country evidenced_country_code
    end
    alias country evidenced_country

    # returns country code
    # TODO remove
    def country_code_of evidence_label
      evidences[evidence_label].country_code
    end

    # returns Country object
    # TODO remove
    def country_of evidence_label
      Eurocrats.country evidences[evidence_label].country_code
    end

    # Are Supplier and Customer European taxable persons? (They have an European VAT number)
    def taxables?
      @supplier.taxable? && @customer.taxable?
    end
    alias b2b? taxables?

    # Stores automatically the VIES validation as an evidence
    def validate_on_vies!
      @evidences[VIES_EVIDENCE_LABEL] = Vies::Validation.new(@supplier, @customer).request!
    end

    def valid_vat_numbers?
      return evidences[VIES_EVIDENCE_LABEL].valid? if evidences.has_key? VIES_EVIDENCE_LABEL
      nil
    end

    # If Supplier and Customer are taxables, it checks that both VAT numbers are
    # valid and creates a new evidence that holds the VIES validation response.
    # If Customer is in the same country than Supplier, even being taxables, VAT
    # should be charged.
    # Then, the Supplier must pay that collected VAT to her tax authorities,
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
    alias charge_vat? should_vat_be_charged?

    def evidenced_vat_rates
      evidenced_country.vat_rates
    end
    alias vat_rates evidenced_vat_rates

    # TODO move to Country or remove
    def vat_rates_in country_code
      Eurocrats.country(country_code).vat_rates
    end

    # TODO vat_for in Evidence?
    def vat_of evidence_label, amount, rate=nil
      if should_vat_be_charged?
      else
        0
      end
    end

    # TODO add the "as" method to Numeric objects
    # TODO admit Numeric as rate
    def vat_for amount, rate=nil
      if should_vat_be_charged?
        rate ||= @rate
        amount * vat_rates[rate] / 100
      else
        0
      end
    end
    alias vat vat_for

    # Adds the VAT if necessary.
    # TODO add the "as" method to Numeric objects
    def with_vat amount, rate=nil
      amount + amount * vat_for(amount, rate)
    end

    # TODO default currency
    # TODO default currency from MoneyRails
    def exchange amount, from, to
    end

    def open &block
      instance_eval &block
    end

    private

      def different_countries?
        @supplier.vat_number.country_code != @consumer.vat_number.country_code
      end

  end

end
