describe Eurocrats::VatNumberValidationsController do

  routes { Eurocrats::Engine.routes }

  let(:vat_number) { 'XX12345678' }

  describe 'paths' do
    it { expect(vat_number_validation_path vat_number).to eq "/vat-number-validations/#{vat_number}" }
  end

  context 'JSON format' do
    let(:params) { {format: 'json'} }

    it 'to #show' do
      expect(get vat_number_validation_path vat_number)
        .to route_to 'eurocrats/vat_number_validations#show', params.merge(vat_number: vat_number)
    end
  end

end
