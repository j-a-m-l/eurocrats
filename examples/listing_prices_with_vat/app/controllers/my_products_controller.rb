class MyProductsController < ApplicationController

  def index
    @products = MyProduct.all
    @vat_rate = Eurocrats::Country[selected_country]['standard']

  # Several things could raise an Eurocrats::Error while is determining the
  # evidenced country:
  #  * The billing address has a country code that does not exist
  rescue Eurocrats::Error
    @epic_fail = true
  end
  
  private

    def selected_country
      session[:selected_country]
    end

    def products
      MyProduct.active
    end

end
