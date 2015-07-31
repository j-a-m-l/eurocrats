# VAT rates for e-services are the same than the standard: http://ec.europa.eu/taxation_customs/tic/public/vatRates/vatratesSearch.html

module Eurocrat
  class VatRates

    TYPES = %[superreduced reduced standard parking]
    # e-commerce => standard 
    # reduces is array

    def self.for country
    end

  end
end
