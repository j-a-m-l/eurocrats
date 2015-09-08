require_relative 'taxable'

module Eurocrats
  ##
  # Supplier holds the data of the service provider.
  # This data is used for:
  #
  # * Evaluating the amount to charge, based on the country and the optional VAT number
  # * Proving, if necessary, that the customer VAT number has been validated in VIES
  # * Invoicing (in the future)
  #
  # This class could be seem as an interface for that functionality and could be replaced
  # with anyone that includes the Taxable module.
  #
  class Supplier

    # Supplier should be taxable persons
    include Taxable

  end
end
