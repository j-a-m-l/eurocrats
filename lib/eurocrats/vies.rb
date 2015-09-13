module Eurocrats

  class ViesError < StandardError; end

  ##
  # This module connects to the VAT Information Exchange Service (VIES).
  #
  # VAT number validation through web interface:
  # http://ec.europa.eu/taxation_customs/vies/vatResponse.html
  #
  # Unavailability:
  # http://ec.europa.eu/taxation_customs/vies/viesspec.do
  # TODO provide alternative services
  #
  module Vies

    # TODO timeouts

    def self.vat_number_exists? number, detail=false
      validate_vat_number number, nil, detail
    end

    def self.validate_vat_number number, requester=nil, detail=false
      Valvat::Lookup.validate number, requester_vat: requester, detail: detail
    end

    def self.validate_vat_number! number, requester=nil, detail=false
      Valvat::Lookup.validate number, requester_vat: requester, detail: detail, raise_error: true
    end

    # TODO return a Validation
    # def validate requester, number
    # end

  end
end
