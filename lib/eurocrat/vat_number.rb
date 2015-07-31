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

      # TODO cache responses for avoiding requests

      def seems_valid? number
        Valvat::Syntax.validate number
      end

      def is_valid? number, detail=false
        Valvat::Lookup.validate number, detail: detail
      end
      alias exists? is_valid?

      def validate number, requester_number=nil, detail=false
        Valvat::Lookup.validate number, detail: detail, requester_vat: requester_number
      end

    end

    attr_reader :vat_number

    # TODO raise if not validated?

    attr_reader :country_code

    attr_reader :request_date
    attr_reader :name
    attr_reader :address
    attr_reader :requester_vat_number

    def initialize number
    end

    # Grece VAT country code is "EL", but their ISO 3166-1 alpha-2 country code is "GR"
    def country_code_alpha2
      country_code == 'EL' ? 'GR' : country_code
    end

    def seems_valid?
      self.class.seems_valid? vat_number
    end

    def is_valid?
      self.class.is_valid? vat_number
    end
    alias exists? is_valid? 

    def validate_for requester_vat_number
      validate (@requester_vat_number = requester_vat_number)
    end

    def validate
      response = self.class.validate vat_number, @requester_vat_number, true
      # TODO
    end

  end
end
