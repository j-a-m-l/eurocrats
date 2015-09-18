class AlternativeComplexController < ApplicationController

  def create

    # Price + VAT for the country of the declared billing address
    billing_address_vat = eurocrats['billing_address'].vat_for product.cost
    total_amount = product.cost + billing_address_vat

    @transaction = MyPayment.authorize_only! total_amount

    # If the CreditCard object responds to `country_code` it is invoked automatically
    eurocrats['credit_card'] = @transaction.credit_card

    # Supplier and Customer are European taxable persons; location evidences are irrelevant
    if eurocrats.taxables?
      @transaction.collect_money!

    # At least 2 of 3 possible evidences match
    elsif eurocrats.enough_evidences?

      # Ensure the price is the same that the one showed in the UI before collecting money
      if billing_address_vat == eurocrats['credit_card'].vat_for(product.cost) ||
         billing_address_vat == eurocrats['ip_location'].vat_for(product.cost)

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
