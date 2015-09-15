require 'valvat'
require 'geocoder'
require 'countries'

require_relative './eurocrats/error'
require_relative './eurocrats/country'
require_relative './eurocrats/evidence'
require_relative './eurocrats/vat_number'
require_relative './eurocrats/vies'
require_relative './eurocrats/vies/validation'
require_relative './eurocrats/evidence'
require_relative './eurocrats/taxable'
require_relative './eurocrats/evidentiable'
require_relative './eurocrats/customer'
require_relative './eurocrats/supplier'
require_relative './eurocrats/context'

require_relative './eurocrats/rack/request'
require_relative './eurocrats/engine'

# Introduction to this mess:
# http://europa.eu/youreurope/business/vat-customs/buy-sell/index_en.htm
#
# More introductions:
# http://www.translatorscafe.com/cafe/article24.htm

# Description of an implementation:
# http://blog.pythonanywhere.com/105/

module Eurocrats

  mattr_accessor :debug
  @@debug = false

  # This supplier will be used, by default, in VIES validations through `Context` and the included `VatNumbersController`, as the requester
  mattr_reader :default_supplier

  def self.default_supplier= data
    case data
      when Supplier
        @@default_supplier = data

      when Hash
        @@default_supplier = Supplier.new
        @@default_supplier.vat_number = data['vat_number'] if data.has_key? 'vat_number'
        @@default_supplier.vat_number = data[:vat_number] if data.has_key? :vat_number

      else raise ArgumentError.new 'Default supplier should be configured from Supplier or Hash object'
    end

    @@default_supplier
  end

  mattr_accessor :country_codes
  @@country_codes = {}

  def self.country code
    ISO3166::Country[code_to_alpha2 code]
  end

end
