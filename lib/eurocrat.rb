require 'valvat'
require 'geocoder'
require 'countries'

require_relative './eurocrat/country'
require_relative './eurocrat/evidence'
require_relative './eurocrat/vat_number'
require_relative './eurocrat/vies'
require_relative './eurocrat/vies/validation'
require_relative './eurocrat/evidence'
require_relative './eurocrat/taxable'
require_relative './eurocrat/evidentiable'
require_relative './eurocrat/customer'
require_relative './eurocrat/supplier'
require_relative './eurocrat/context'

require_relative './eurocrat/rack/request'
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

  # Supplier data
  mattr_accessor :default_supplier

  mattr_accessor :country_codes
  @@country_codes = {}

  def self.country code
    ISO3166::Country[code_to_alpha2 code]
  end

end
