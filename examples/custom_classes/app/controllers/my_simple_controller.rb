class MySimpleController < ApplicationController

  def create

    # Adds the VAT using the evidenced country if is necessary
    total_amount = eurocrats.with_vat product.price

    @transaction = MyPayment.authorize_and_settle! total_amount

  # Several things could raise an Eurocrats::Error while is determining the
  # evidenced country:
  #  * The 2 evidences (IP address and billing address) do not match
  #  * The VIES validation fails
  #  * The billing address has a country code that does not exist
  rescue Eurocrats::Error
    @epic_fail = true
  end
  
  private

    # This method returns an Eurocrat::Context with the default supplier and a
    # customer that has a VAT number.
    #
    # It includes 2 evidences, one explicit ("billing_address") and other, the
    # IP address, that has been captured by `request.eurocrats` already
    def eurocrats
      customer = Eurocrats::Customer.new
      customer.vat_number = vat_number_param if vat_number_param

      request.eurocrats Eurocrats.default_supplier, customer
      request.eurocrats['billing_address'] = billing_address_param
    end

    def billing_address_param
      params.require :billing_address, :country_code
    end

    def vat_number_param
      params.require :customer, :vat_number
    end

    def product
      MyProduct.find params.require(:id)
    end

end
