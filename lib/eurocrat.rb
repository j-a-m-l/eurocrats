require 'valvat'
require 'geocoder'
require 'countries'

require_relative "./eurocrat/address"
require_relative "./eurocrat/vat_number"
require_relative "./eurocrat/customer"
require_relative "./eurocrat/judge"
require_relative './eurocrat/context'
require_relative './eurocrat/engine'
require_relative './eurocrat/rack/request'

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

  # Supplier data
  mattr_accessor :default_supplier

  mattr_accessor :country_codes
  @@country_codes = {}

end
