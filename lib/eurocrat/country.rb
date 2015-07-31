module Eurocrat

  class InvalidCountryCodeError < StandardError; end

  # TODO merge with VAT rates
  # TODO inherit from Country (countres gem)?
  class Country

    class << self

      # From ISO 3166-1 numeric or ISO 3166-1 alpha-3 to ISO 3166-1 alpha-2
      # def to_alpha2_country_code code
      # TODO refactor this mess
      def country_code_to_alpha2 code
        code = code.to_s if code.is_a? Integer

        if code.is_a? String
          if code.length == 2
            if ISO3166::Country[code]
              return code
            else
              raise_non_existent code, 'alpha-2'
            end

          elsif code.length == 3

            # It is string that could be used as an integer
            if code[/\d{3}/] == code
              country = ISO3166::Country.find_all_by 'number', code
              if country.any?
                return country.values.first['alpha2']
              else
                raise_non_existent code, 'numeric'
              end

            else
              country = ISO3166::Country.find_all_by 'alpha3', code
              if country.any?
                return country.values.first['alpha2']
              else
                raise_non_existent code, 'alpha-3'
              end
            end
          end
        end

        raise Eurocrat::InvalidCountryCodeError.new 'The code can not be converted to ISO 3166-1 alpha-2'
      end
      alias to_alpha2 country_code_to_alpha2

      private

        def raise_non_existent code, type
          raise Eurocrat::InvalidCountryCodeError.new "\"#{code}\" is not an existent ISO 3166-1 #{type} code"
        end

    end

  end

end
