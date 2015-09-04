require_relative './concerns/eurocratable'

module Eurocrats
  class VatNumbersController < ApplicationController

    # TODO GET /vat-numbers/:vat_number/valid
    # TODO GET /vat-number-validation/:vat_number
    # GET /vat-numbers/:vat_number
    #
    # TODO validate for supplier
    # TODO return errors
    #
    # TODO improve security: limit petitions, add delays
    def show
      @valid = validation
    end

    protected

      def validation
        Eurocrats::Vies.validate_vat_number vat_number_param
      end

    private

      def vat_number_param
        params.require :vat_number
      end

  end
end
