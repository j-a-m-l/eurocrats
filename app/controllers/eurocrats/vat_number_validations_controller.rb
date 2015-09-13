require_relative './concerns/eurocratable'

module Eurocrats
  ##
  # This controller manages the VAT number validations
  #
  class VatNumberValidationsController < ApplicationController

    # GET /vat-number-validations/:vat_number
    #
    # It validates a VAT number against the VIES, using the protected method
    # `requester_vat_number` value as requester, which uses the default supplier
    # VAT number, and can be overwritten for specific purposes.
    #
    # When the validation is performed successfully, it responds:
    # `{ valid: true }`
    # `{ valid: false }`
    #
    # When there is an error during the validation, it responds:
    # `{ valid: null }`
    #
    # When the request is incorrectly formated (the VAT number is empty), it
    # responds only with headers and the HTTP status code 400.
    #
    def show
      @valid = Eurocrats::Vies.validate_vat_number! requester_vat_number, vat_number_param

    rescue ActionController::ParameterMissing
      head :bad_request

      # TODO Add error codes or messages
      # TODO optional logging
    rescue => e
      @valid = nil
    end

    protected

      # The default value is the default supplier VAT number
      # This method could be overwritten for returning VAT numbers
      def requester_vat_number
        Eurocrats.default_supplier.vat_number
      end

    private

      def vat_number_param
        params.require :vat_number
      end

  end
end
