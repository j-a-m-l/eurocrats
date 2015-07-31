# VAT number
#
# Some incomplete validation rules:
# http://ec.europa.eu/taxation_customs/vies/faqvies.do#item_11
#
# VAT number validation through web interface:
# http://ec.europa.eu/taxation_customs/vies/vatResponse.html
#
# Unavailability:
# http://ec.europa.eu/taxation_customs/vies/viesspec.do
# TODO provide alternative services
#
module Eurocrat
  class VatNumber

    class << self

      # TODO cache vat checkings for avoiding requests

      def seems_valid? number
        Valvat::Syntax.validate number
      end

      def is_valid? number, detail=false
        Valvat::Lookup.validate number, detail: detail
      end
      alias exists? is_valid?

      def check number, requester_number=nil, detail=false
        response = Valvat::Lookup.validate number, detail: detail, requester_vat: requester_number
      end

      # def query number
      #   Valvat(number)
      # end

    end

    attr_reader :country
    attr_reader :number
    attr_reader :address
    attr_reader :detail
    @@detail = {
      country_code: nil,
      vat_number: '',
      request_date: nil, # Date instead of DateTime?

      # Optional
      name: '',
      address: '',
    }

    # TODO Greece? => country_code_alpha2

    # TODO requester
    attr_reader :validated_for

    def initialize number
    end

    def seems_valid?
      self.class.seems_valid? number
    end

    def is_valid?
      self.class.is_valid? number
    end

  end
end
