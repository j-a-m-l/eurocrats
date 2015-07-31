module Eurocrat
  #
  #
  # It normalizes all the country codes to ISO 3166-1 alpha-2
  #
  class Evidence

    # TODO extensible
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

        # TODO class
        raise StandardError
      end

      # Tries to recognize an acceptable country code
      def from_object object
        COUNTRY_CODE_KEYS.each do |key|
          if object.respond_to? key.to_sym
            return new object.__send__(key), object
          end
        end

        # TODO class
        raise StandardError
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

    # ISO 3166-1 alpha-2
    attr_reader :country_code

    # Object that contains the country code that supports the evidence
    attr_reader :data

    def initialize country_code, data
      @country_code, @data = Country.to_alpha2(country_code), data
    end

  end
end
