module Eurocrats
  module Evidentiable

    class << self

      # TODO
      def eurocrats_evidence label, method
      end

      unless respond_to? :evidence
        alias evidence eurocrats_evidence
      end

    end

    # TODO
    def collect_eurocrats_evidences
      {}
    end

  end
end
