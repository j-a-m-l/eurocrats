Eurocrats::Engine.routes.draw do

  scope format: 'json' do
    get 'vat-number-validations/:vat_number' => 'vat_number_validations#show', as: 'vat_number_validation'
  end

end
