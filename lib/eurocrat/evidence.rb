module Eurocrat
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
        new code
      end

      def from_geocoder_result result
        new result.country_code, result
      end

      def from_vat_number vat_number
        new vat_number.country_code, vat_number
      end

      # Tries to recognize an acceptable country code
      def from_hash hash
      end

      # Tries to recognize an acceptable country code
      def from_object object
      end

      def new source
        builder = case source
          when Integer, String then :from_country_code
          when Geocoder::Result then :from_geocoder_result
          when VatNumber then :from_vat_number
          when Hash then :from_hash
          else :from_object
        end

        __send__ builder, source
      end

    end

    def initialize country_code, data=nil
    end

    # ISO 3166-1 alpha-2
    attr_reader :country_code

    attr_reader :data

  end
end
