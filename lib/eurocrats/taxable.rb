module Eurocrats
  ##
  # This module provides functionality for taxable persons.
  # Those are from whom governments collect VAT, like companies or freelancers,
  # although they usually passed it on to their customers.
  #
  module Taxable

    attr_reader :vat_number

    def vat_number= id
      @vat_number = id.is_a?(VatNumber) ? id : VatNumber.new(id)
    end

    def taxable?
      not vat_number.nil? 
    end

  end
end
