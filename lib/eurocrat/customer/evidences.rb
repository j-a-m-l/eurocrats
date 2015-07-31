module Eurocrat
  class Customer
    class Evidences

      def << evidence
        unless [Hash, VatNumber].include? evidence.class
          raise ArgumentError.new 'Evidence should be a Hash or VatNumber object'
        end

        # if evidence.is_a? Address
          # evidences['eurocrat.request.ip_location'] = evidence
        # end

        if evidence.is_a? Address
          @customer.address = evidence
          evidences['eurocrat.address'] = evidence
        end

        if evidence.is_a? VatNumber
          @customer.vat_number = evidence
          evidences['eurocrat.vat_number'] = evidence
        else

        end

        self
      end

    end
  end
end
