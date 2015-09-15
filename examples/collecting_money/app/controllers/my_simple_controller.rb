class MySimpleController < ApplicationController

  def create

    # Adds the VAT if necessary (and determines the country if has not been done)
    total_amount = eurocrats.with_vat product.price

    @transaction = MyPayment.authorize_and_settle! total_amount

  # Several things could raise an Eurocrats::Error while is determining the
  # evidenced country:
  #  * The 2 evidences (IP address and billing address) do not match
  #  * The VIES validation fails (connection error, invalid VAT number, etc.)
  #  * The billing address has a country code that does not exist
  rescue Eurocrats::Error
    @epic_fail = :maybe

  # Other errors
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
