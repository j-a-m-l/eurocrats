# Some incomplete validation rules:
# http://ec.europa.eu/taxation_customs/vies/faqvies.do#item_11

# VAT number validation through web interface:
# http://ec.europa.eu/taxation_customs/vies/vatResponse.html

# Unavailability:
# http://ec.europa.eu/taxation_customs/vies/viesspec.do
# TODO provide alternative services

# Operations:
# * check_vat
# * check_vat_approx
module Eurocrat
  class VatNumber

    class << self

      # TODO cache vat checkings for avoiding requests

      def seems_valid? number
        Valvat::Syntax.validate number
      end

      def exists? number
        Valvat::Lookup.validate number
      end

      def check number, requester_number=nil, detail=false
        response = Valvat::Lookup.validate number, detail: detail, requester_vat: requester_number
      end

      # def query number
      #   Valvat(number)
      # end

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
