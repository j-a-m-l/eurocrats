module Eurocrat
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
