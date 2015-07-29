class Eurocrat::VatNumbersController < Eurocrat::ApplicationController
  include Eurocrat::Concerns::VatNumber

  # GET /vat-numbers/:vat_number
  #
  # TODO improve security: limit petitions, add delays
  def show
    render json: check_vat_number
  end

end
