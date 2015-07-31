require 'forwardable'

module Eurocrat

  # Context reunites the entities that could be used for determining, among other questions, these:
  #
  # * What are the evidences of the customer location?
  # * Are they enough?
  # * What are the VAT rates that correspond to that location?
  # * How much should be charged?
  #
  # TODO This is the unique method that could be called before having obtained enough
  # evidences of the customer location.
  # Other methods raise a `ConflictingEvidencesError` in that case because they
  # can't operate without knowing the country.
  #
  class Context
    extend Forwardable

    attr_reader :supplier

    attr_reader :customer
    def_delegators :@customer, :evidences, :<<

    attr_reader :judge

    # TODO options...
    def initialize supplier=nil, customer=nil, judge=nil
      # TODO default supplier
      # @supplier ||= Supplier.new

      @customer ||= Customer.new

      # TODO default judge
      @judge ||= Judge.new

      # TODO default rate
      @rate = 'standard'
    end

    # def use_as_default_rate rate
    #   @supplier.default_rate = rate
    # end

    def enough_evidences?
      (@decided_country = @judge.verdict @customer) != false
    end
    alias enough? enough_evidences?

    def decided_country
      raise unless enough_evidences?
      @decided_country
    end

    def vat_rates
      VatRates.for decided_country
    end

    # If the user is in the same country than the supplier, it should usually be charged.
    # Then, the supplier must pay that collected VAT, although she can deduct her paid VAT
    def vat_must_be_charged?
      if decided_country == @supplier.country
        true
      else
        not @customer.valid_vat_number?
      end
    end

    # def with_vat amount, rate=nil
    #   unless vat_must_be_charged?
    #     rate ||= @rate
    #     amount = amount * vat_rates[rate] / 100
    #   end

    #   # TODO add the "as" method to Numeric objects

    #   amount
    # end

  end
end
