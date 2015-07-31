module Eurcrat
  # Supplier holds the data of the service supplier
  # This data is used for:
  #
  # * Evaluating the amount to charge, based on the country and the optional VAT number
  # * Proving, if necessary, that the customer VAT number has been validated in VIES
  # * Invoicing (in the future)
  #
  class Supplier

    attr_accessor :address

    attr_accessor :vat_number

    attr_accessor :default_rate

  end
end
