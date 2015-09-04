Eurocrats::Engine.routes.draw do

  scope format: 'json' do
    get 'vat-numbers/:vat_number' => 'vat_numbers#show', as: 'vat_number_validation'
  end

end
