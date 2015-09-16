class MyProduct < ActiveRecord::Base

  def calculate_vat eurocrats
    eurocrats.vat_of 'selected_country'
  end

  def calculate_price_with_vat eurocrats
    eurocrats.with_vat_of 'selected_country', self.price
  end

  validates :price, {
      presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 999,
      }
    }

end
