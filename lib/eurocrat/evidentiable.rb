module Eurocrat
  module Evidentiable

    class << self

      # TODO
      def eurocrat_evidence label, method
      end

      unless respond_to? :evidence
        alias evidence eurocrat_evidence
      end

    end

    # TODO
    def collect_eurocrat_evidences
      {}
    end

  end
end
