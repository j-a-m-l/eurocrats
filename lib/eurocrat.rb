require 'valvat'

require_relative "./eurocrat/vat_number"
require_relative "./eurocrat/user"
require_relative './eurocrat/engine'

# Introduction to this mess:
# http://europa.eu/youreurope/business/vat-customs/buy-sell/index_en.htm
#
# More introductions:
# http://www.translatorscafe.com/cafe/article24.htm

# Description of an implementation:
# http://blog.pythonanywhere.com/105/

module Eurocrat

  mattr_accessor :debug
  @@debug = false

  mattr_accessor :country

  mattr_accessor :country_codes
  @@country_codes = {}

  # If you exceeds these limits, you should start charging VAT TODO
  mattr_accessor :thresholds_by_country
  @thresholds_by_country = {}

  # Web Service URL
  mattr_reader :vies_wsdl_url
  @@vies_wsdl_url = 'http://ec.europa.eu/taxation_customs/vies/checkVatService.wsdl'

end
