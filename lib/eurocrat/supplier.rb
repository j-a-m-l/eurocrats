require_relative 'taxable'

module Eurocrat
  # Supplier holds the data of the service supplier
  # This data is used for:
  #
  # * Evaluating the amount to charge, based on the country and the optional VAT number
  # * Proving, if necessary, that the customer VAT number has been validated in VIES
  # * Invoicing (in the future)
  #
  class Supplier
    include Taxable
  end
end
