describe Eurocrats::VatNumberValidationsController do

  routes { Eurocrats::Engine.routes }

  # Valid and real VAT numbers (Google and eBay)
  let(:vat_number) { 'IE6388047V' }
  let(:other_vat_number) { 'LU21416127' }

  describe '#show' do
    before(:each) { Eurocrats.default_supplier = { vat_number: vat_number } }

    let(:get_show) { get :show, format: :json, vat_number: vat_number }

    let(:validation_result) { double 'Validation Result' }

    let(:mock_validation!) {
      expect(controller).to receive(:requester_vat_number).and_return other_vat_number
      expect(Eurocrats::Vies).to receive(:validate_vat_number!).and_return validation_result
    }

    it 'uses the requester VAT number' do
      mock_validation!
      get_show
    end

    it 'responds with status 200' do
      mock_validation!
      expect(get_show.status).to be 200
    end

    it 'assigns the result of the validation to the view' do
      mock_validation!
      get_show
      expect(assigns :valid).to eq validation_result
    end

    context 'with empty VAT number' do
      before(:each) { get :show, format: :json, vat_number: '' }

      it_responds :bad_request, with_json: { success: nil }
    end

    context 'on error' do
      context 'when VIES VAT service is unavailable' do
      end

      context 'when VAT database of the customer country is unavailable' do
      end

      context 'when connection fails' do
        # SocketError
      end

      context 'when request times out' do
      end

      context 'when unknown problems happen' do
      end
    end
  end

  describe '#requester_vat_number' do
    context 'with a default supplier' do
      before(:each) { Eurocrats.default_supplier = { vat_number: vat_number } }

      it 'returns its VAT number' do
        expect(controller.__send__ :requester_vat_number).to be Eurocrats.default_supplier.vat_number
      end
    end

    context 'without a default supplier' do
      before(:each) { Eurocrats.class_variable_set :@@default_supplier, nil }

      it 'raises an error' do
        expect { controller.__send__ :requester_vat_number }.to raise_error
      end
    end
  end
  
end
