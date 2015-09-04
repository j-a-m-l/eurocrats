require_relative 'vies'

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
module Eurocrats
  class VatNumber

    class InvalidError < StandardError; end

    def self.seems_valid? vat_number
      Valvat::Syntax.validate vat_number
    end

    # attr_reader :vat_number
    attr_reader :number
    attr_reader :country_code

    # TODO raise if doesn't exist?
    def initialize vat_number
      @vat_number = vat_number
      raise InvalidError.new "\"#@vat_number\" is not a valid VAT number" unless seems_valid?
    end

    # Grece VAT country code is "EL", but their ISO 3166-1 alpha-2 country code is "GR"
    def country_code_alpha2
      country_code == 'EL' ? 'GR' : country_code
    end

    def seems_valid?
      self.class.seems_valid? @vat_number
    end

    def to_s
      @vat_number
    end

  end
end
