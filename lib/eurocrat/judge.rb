module Eurocrat

  # Yeah, for judging evidences
  #
  # This class compares the collected evidences and emits a verdict
  # That verdict is the location (ISO 3166-1 alpha-2 country code) of the customer
  # (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
  #
  # The default strategy is to find 2 evidences with the same country code
  #
  # Overriding the `conflicts` method is enough for creating a custom strategy,
  # like ignoring evidences on some conditions or requiring more than 2 evidences
  # 
  class Judge

    # Country code
    def verdict supplier, customer
      customer.evidences.any? && conflicts(customer.evidences).any?
    end



    # If customer is in the same country than supplier, it should be charged
    # Then, the supplier must pay that collected VAT to her tax authorities,
    # although she could deduct her paid VAT
    # => true
    # => false
    # => nil
    def should_vat_be_charged?
      # TODO nil...
      if taxables?
         different_countries?
      elsif Country.in_european_union? verdict
        true
      else
        false
      end
    end



    def taxables?
      @supplier.taxable? && @customer.taxable? && validated_vat_numbers?
    end
    alias b2b? taxables?

    # Stores automatically the VIES validation as an evidence
    def validate_on_vies
      validation = Vies::Validation.new(@supplier, @customer).request

      if validation
        customer['eurocrat.b2b.vies.validation'] = validation
      elsif customer.has_key? 'eurocrat.b2b.vies.validation'
        customer.delete! 'eurocrat.b2b.vies.validation'
      end

      validation
    end
    alias validated_vat_numbers? validate_on_vies



    def conflicts evidences
      country_codes = evidences.values.map {|evidence| evidence.country_code_alpha2 }
      evidences.reduce({}) do |conflicts, label, evidence|
        conflicts.merge label => evidence
      end
    end
    alias conflicting_evidences conflicts 

    def non_conflicting_evidences
      #evidences - conflicts
    end
    alias not_conflicting_evidences non_conflicting_evidences


    private

      def different_countries?
        @supplier.vat_number.country_code != @consumer.vat_number.country_code
      end

  end

end
