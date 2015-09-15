class AlternativeComplexController < ApplicationController

  def create

    # Price + VAT for the country of the declared billing address
    total_amount = eurocrats.with_vat_of 'billing_address', product.cost

    @transaction = MyPayment.authorize_only! total_amount
    eurocrats['credit_card.country'] = @transaction.credit_card.country_code

    # Supplier and Customer are European taxable persons; evidences are not required
    if eurocrats.taxables?
      @transaction.collect_money!

    # At least 2 of 3 possible evidences match
    elsif eurocrats.enough_evidences?

      # Ensure the price is the same that the one showed in the UI
      if vat_of('billing_address') == vat_of('credit_card.country') ||
         vat_of('billing_address') == vat_of('eurocrats.request.ip_location')

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