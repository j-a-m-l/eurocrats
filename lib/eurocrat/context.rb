module Eurocrat
  class Context

    attr_accessor :evidences

    # TODO required supplier
    def initialize supplier=nil
      @evidences = {}
    end

    # TODO delegate @evidences

    def << evidence
      unless [Hash, VatNumber].include? evidence.class
        raise ArgumentError.new 'Evidence should be a Hash or VatNumber object'
      end

      if evidence.is_a? VatNumber
        self << { 'vat_number' => evidence }
      else

      end

      self
    end

  end
end
