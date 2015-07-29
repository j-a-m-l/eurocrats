module Eurocrat
  module Concerns
    module VatNumber
      extend ActiveSupport::Concern

      def check_vat_number
        VatNumber.check vat_number_param
      end

      def vat_number_exists?
      end

      def vat_number_param
        params.require :vat_number
      end

    end
  end
end
