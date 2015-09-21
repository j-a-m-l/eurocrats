module Eurocrats
  #
  # Some evidences prove the customer location, while others don't
  #
  # It normalizes all the country codes to ISO 3166-1 alpha-2
  # (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)
  #
  class Evidence

    # TODO use method with Regex
    COUNTRY_CODE_KEYS = %w[
      country_code_alpha2
      country_code_alpha3
      country_code_numeric
      country_code
      country
    ]

    class << self

      def from_country_code code
        new code, code
      end

      # Tries to recognize an acceptable country code
      def from_hash hash
        COUNTRY_CODE_KEYS.each do |key|
          country_code = hash[key] || hash[key.to_sym]
          return new(country_code, hash) if country_code
        end

        raise InvalidCountryCodeError.new 'No available country code key'
      end

      # Tries to recognize an acceptable country code
      def from_object object
        COUNTRY_CODE_KEYS.each do |key|
          if object.respond_to? key.to_sym
            return new object.__send__(key), object
          end
        end

        raise InvalidCountryCodeError.new 'No available country code method'
      end

      def from source
        builder = case source
          when Integer, String then :from_country_code
          when Hash then :from_hash
          else :from_object
        end

        __send__ builder, source
      end

    end

    # ISO 3166-1 alpha-2, extracted from the source of the evidence
    # TODO remove: use country.code
    attr_reader :country_code

    # Object that contains the information that supports the evidence
    attr_reader :source

    # The exact moment in which the evidence was collected
    attr_reader :collected_at

    # The current context in which this evidence is being used
    attr_accessor :context

    def initialize country_code, source, context=nil
      # TODO dup && freeze the source?
      @country_code, @source, @context = Country.to_alpha2(country_code), source, context
      @collected_at = DateTime.now
    end

    # Returns the Country (as object) of this evidence
    def country
      ISO3166::Country[@country_code]
    end

    # Returns a Hash with the VAT rates that are applied to the country of this evidence
    def vat_rates
      country.vat_rates
    end

    # Only if it belongs to a Context. It returns the VAT that should be charged
    # when the country is the same that the one of this Evidence.
    def vat_for_current_context rate=nil
      if context_or_raise!.should_vat_be_charged? country
        vat_rates[ (rate || context.vat_rate) ]
      else
        0
      end
    end
    alias vat vat_for_current_context

    # Only if it belongs to a Context. It returns the VAT that should be charged
    # for an amount, when the country is the same that the one of this Evidence.
    def calculate_vat_for amount, options={}
      amount * vat_for_current_context(vat_rate: options[:rate])
    end
    alias vat_for calculate_vat_for

    # TODO
    def calculate_with_vat amount, options={}
      amount + calculate_vat_for(amount, options)
    end
    alias with_vat calculate_with_vat

    private

      def context_or_raise!
        @context or raise EvidenceWithoutContextError.new 'Evidence needs a Context for performing the operation'
      end

  end
end
