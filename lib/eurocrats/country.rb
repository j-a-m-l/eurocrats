module Eurocrats

  # VAT rates for e-services are the same than the standard ones:
  # http://ec.europa.eu/taxation_customs/tic/public/vatRates/vatrates.html
  # TYPES = %[superreduced reduced standard parking]
  # e-commerce => standard 
  # reduced is an array

  # This Country class simplifies the handling of different country codes.
  # It extends the Country class from the `countries` gem.
  #
  class Country < ISO3166::Country

    class << self

      # From ISO 3166-1 numeric or ISO 3166-1 alpha-3 to ISO 3166-1 alpha-2
      # def to_alpha2_country_code code
      def code_to_alpha2 code
        code = code.to_s if code.is_a? Integer

        unless code.is_a? String and code.length.between? 2, 3
          raise Eurocrats::InvalidCountryCodeError.new 'The argument is not a valid ISO 3166-1 code'
        end

        if code.length == 2
          self[code] ? code : raise_non_existent(code, 'alpha-2')

        elsif code.length == 3

          # If is a string that could be used as an integer
          key_and_type = (code[/\d{3}/] == code) ? %w[number numeric] : %w[alpha3 alpha-3]

          search_and_convert_code_to_alpha2 code, *key_and_type
        end
      end
      alias to_alpha2 code_to_alpha2

      def vat_rates_in country_or_code
        as_country(country_or_code).vat_rates
      end

      def in_european_union? country_or_code
        as_country(country_or_code).in_eu?
      end
      alias in_eu? in_european_union?

      private

        def search_and_convert_code_to_alpha2 code, key, type
          country = find_all_by key, code
          if country.any?
            country.values.first['alpha2']
          else
            raise_non_existent code, type
          end
        end

        def raise_non_existent code, type
          raise Eurocrats::InvalidCountryCodeError.new "\"#{code}\" is not a ISO 3166-1 #{type} code"
        end

        def as_country country_or_code
          case country_or_code
            when self             then country_or_code
            when ISO3166::Country then self[ country_or_code.alpha2 ]
            else                       self[ to_alpha2(country_or_code) ]
          end
        end

    end

    alias code alpha2
    alias alpha2_code alpha2

    # TODO
    # def == other
    # end

  end
end
