require 'forwardable'

module Eurocrat

  # Yeah, for judging evidences
  #
  # This class compares the collected evidences and emits a verdict
  # That verdict is the location (ISO 3166-1 alpha-2 country code) of the customer
  #
  # The default strategy is to find 2 evidences with the same country code
  #
  # Overriding the `comparator` private method could be enough for creating a custom strategy,
  # like ignoring evidences on some conditions or requiring more than 2 evidences
  # 
  class Judge
    extend Forwardable
    
    attr_accessor :evidences
    # TODO more methods
    def_delegators :@evidences, :[], :[]=, :each_pair, :delete, :merge

    def initialize
      # @customer
      @evidences = {}
    end

    def verdict
    end

    def conflicting_evidences
    end
    alias conflicts conflicting_evidences 

    def non_conflicting_evidences
      evidences - conflicts
    end
    alias not_conflicting_evidences non_conflicting_evidences

    def enough?
    end

    def conflict?
      not enough?
    end

    private

      def comparator
      end

  end

  class Eurocrat::ConflictingEvidencesError < StandardError; end

end
