require 'forwardable'

module Eurocrat

  # Customer holds the items that prove the customer current VAT circumstance
  #
  # * The evidences of the customer location
  # * VAT number of the customer
  # * (In the future it could include if the customer has some kind of exemption)
  #
  # TODO easy ActiveRecord
  #
  class Customer
    extend Forwardable

    # TODO ?
    attr_reader :date

    attr_accessor :billing_address
    attr_accessor :ip_location
    attr_reader :vat_number

    attr_accessor :evidences
    @@evidences = {

      # An Address object
      billing_address: nil,

      # IP based location (is a Geocoder::Result object)
      ip_location: nil,

      bank: {
        # Location of the account used for payment
        location: nil,
        # Billing address of the customer held by the bank
        billing_address: nil,
      },

      credit_card: {
        location: nil,
        country_of_issuance: nil,
      },

      mobile: {
        # Mobile Country Code
        mcc: nil,
        phone_number: nil,
      },

      # This should be a good evidence, but it isn't explicitly mentioned in any document 
      vat_number: nil,

      # "Other commercially relevant information"
      # Here could be dragons or whatever you think is useful
    }

    def initialize data=nil
      # if ip
      #   @ip_location[:ip] = ip
      # end
    end

    def << evidence
      case evidence
        when VatNumber then vat_number = evidence
        when Hash then evidence.each_pair {|k, v| @evidences[k] = Evidence.new v }
        else raise ArgumentError.new 'Evidence should be a Hash or a VatNumber object'
      end

      self
    end

    def vat_number= vat_number
      @vat_number = vat_number.is_a?(VatNumber) ? vat_number : VatNumber.new vat_number
      @evidences['eurocrat.vat_number'] = Evidence.new @vat_number
    end

    # TODO rename has_a_valid_vat_number?
    def valid_vat_number?
      if vat_number
        check_vat_number
      else
        false
      end
    end

    def check_vat_number
      @vat_number = VatNumber.check @vat_number, @supplier.vat_number
    end


    #
    # TODO not required in Rack (Geocoder gem does it)
    #

    def locate
      Geocoder.search @ip_location[:ip]
    end

    def update_location
      raise Eurocrat::IpLocationError.new 'lol' unless (new_location = locate_ip)

      # TODO more than one
      @ip_location = new_location.first
    end

  end

  class IpLocationError < StandardError; end

end
