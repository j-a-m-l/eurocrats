class MyComplexController < ApplicationController

  def create

    # Supplier and Customer are European taxable persons or IP and billing addresses match
    if eurocrats.taxables? || eurocrats.enough_evidences?

      # Adds the VAT using the evidenced country, only if is necessary
      total_amount = eurocrats.with_vat product.cost
      @transaction = MyPayment.authorize_only!(total_amount).collect_money!

    # Without enough evidences, try to get the credit card country as evidence
    else

      # Price + VAT for the country of the declared billing address
      total_amount = eurocrats.with_vat_of 'billing_address', product.cost

      @transaction = MyPayment.authorize_only! total_amount
      eurocrats['credit_card.country'] = @transaction.credit_card.country_code

      # Billing country and credit card country match
      if eurocrats.favorable_evidences? 'billing_address', 'credit_card.country'
        @transaction.collect_money!

      # 2 of 3 possible evidences match (IP address and credit card)
      elsif eurocrats.enough_evidences?

        # Ensure the price is the same that the one showed in the UI
        if eurocrats.vat_of('billing_address') == eurocrats.vat_of('credit_card.country')
          @transaction.collect_money!
        else

          # Total amount could be different, so cancel this payment
          @transaction.void_authorization!
          @error = 'Charged VAT should be different'
        end

      # All evidences are different
      else
        @transaction.void_authorization!
        @error = 'IP country and billing country do not match'
      end
    end

  rescue Eurocrats::InvalidCountryCodeError
    @error = 'Invalid billing country'

  rescue Eurocrats::ViesError
    @error = 'Error validating the VAT numbers'

  # Other errors that do not depend on Eurocrats
  rescue MyPayment::Error
    @epic_fail = :yeah
  end
  
  private

    # This method returns an Eurocrat::Context with the default supplier and a
    # customer that has a VAT number.
    #
    # It includes 2 evidences, one explicit ("billing_address") and other, the
    # IP address, that has been captured by `request.eurocrats` already
    def eurocrats
      customer = Eurocrats::Customer.new customer_params

      request.eurocrats Eurocrats.default_supplier, customer
      request.eurocrats['billing_address'] = billing_address_params
    end

    def billing_address_params
      params.require :billing_address, :country_code
    end

    def customer_params
      params.require :customer, :vat_number
    end

    def product
      MyProduct.find params.require(:id)
    end

end
