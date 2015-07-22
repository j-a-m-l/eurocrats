# Some incomplete validation rules:
# http://ec.europa.eu/taxation_customs/vies/faqvies.do#item_11

# VAT number validation through web interface:
# http://ec.europa.eu/taxation_customs/vies/vatResponse.html

# TODO provide alternative services

# Operations:
# * check_vat
# * check_va_approx
module Eurocrat
  class VatNumber

    class << self

      def seems_valid? number
        true
      end

      def is_valid? number
      end

      def check number
        Eurocrat.debug = true

        return nil unless seems_valid? number

        # TODO open_timeout
        # TODO read_timeout
        client = Savon.client(
          wsdl: Eurocrat.vies_wsdl_url,
          # element_form_default: :qualified,
          pretty_print_xml: Eurocrat.debug,
        )

        # require 'byebug'; byebug;
      rescue
      end

    end

    attr_reader :country
    attr_reader :number

    def initialize number
    end

    def seems_valid?
    end

    def is_valid?
    end

  end
end
