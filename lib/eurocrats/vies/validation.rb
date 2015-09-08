require_relative '../vies'
require_relative '../vat_number'

module Eurocrats
  module Vies
    ##
    # This class can connect to VIES and hold the data that VIES responds.
    #
    # Its main use case is storing the response that VIES provides as an evidence
    # of the taxable status of a customer (if its VAT number exists).
    #
    class Validation

      attr_reader :requester_vat_number
      attr_reader :vat_number

      # Date, not DateTime
      attr_reader :request_date
      attr_reader :request_identifier

      # Optional
      attr_reader :name
      attr_reader :address
      attr_reader :company_type

      # TODO Taxable instances
      def initialize requester_vat_number, vat_number
        @requester_vat_number = instantiate_if_necessary requester_vat_number
        @vat_number = instantiate_if_necessary vat_number
      end

      def request
        set_properties_from Eurocrats::Vies.validate_vat_number(vat_number, requester_vat_number, true)
      end

      def request!
        set_properties_from Eurocrats::Vies.validate_vat_number!(vat_number, requester_vat_number, true)
      end

      def success?
        not request_date.nil?
      end

      private

        def instantiate_if_necessary vat_number
          vat_number.is_a?(VatNumber) ? vat_number : VatNumber.new(vat_number)
        end

        # TODO rename
        def set_properties_from response
          if response
            @request_date = response[:request_date]
            @name = response[:name] if response.has_key? :name
            @address = response[:address] if response.has_key? :address
            # TODO more attrs
          else
            response
          end
        end

    end
  end
end
