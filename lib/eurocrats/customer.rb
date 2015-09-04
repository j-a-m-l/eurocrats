require_relative 'taxable'
require_relative 'evidentiable'

module Eurocrats

  # Customer is a "drop-in" class that could be replaced with your User, Client, etc.
  #
  # It is composed by 2 modules, Taxable and Evidentiable, that could prove the
  # customer current VAT circumstance:
  #
  # * The evidences of the customer location (Evidentiable)
  # * The VAT number of the customer (Taxable && Evidentiable)
  # * (In the future it could include if the customer has some kind of exemption)
  #
  class Customer

    # Some customers could be "taxable" persons
    include Taxable

    # For collecting the evidences
    include Evidentiable

  end
end
