require_relative '../vies'
require_relative '../vat_number'

module Eurocrat
  module Vies
    class Validation

      attr_reader :requester_vat_number
      attr_reader :vat_number

      # Date, not DateTime
      attr_reader :request_date

      # Optional
      attr_reader :name
      attr_reader :address

      def initialize requester_vat_number, vat_number
        @requester_vat_number = instantiate_if_necessary requester_vat_number
        @vat_number = instantiate_if_necessary vat_number
      end

      def request
        response = Eurocrat::Vies.validate_vat_number(vat_number, requester_vat_number, true)
        response ? set_properties_from(response) : response
      end

      def request!
        set_properties_from Eurocrat::Vies.validate_vat_number!(vat_number, requester_vat_number, true)
      end

      def success?
        not request_date.nil?
      end

      private

        def instantiate_if_necessary vat_number
          vat_number.is_a?(VatNumber) ? vat_number : VatNumber.new(vat_number)
        end

        def set_properties_from response
          @request_date = response[:request_date]
          @name = response[:name] if response.has_key? :name
          @address = response[:address] if response.has_key? :address
        end

    end
  end
end
