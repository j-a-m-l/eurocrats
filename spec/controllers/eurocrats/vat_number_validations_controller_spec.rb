describe Eurocrats::VatNumberValidationsController do

  routes { Eurocrats::Engine.routes }

  let(:vat_number) { 'EX4MP13' }

  let(:get_show) { get :show, format: :json, vat_number: vat_number }

  describe '#show' do

    xcontext 'bad request' do
      describe 'without VAT number' do
        before(:each) { get :show, {} }

        it_responds :bad_request, with_json: { success: false }
      end

      describe 'with unpermitted parameters' do
        before(:each) { get :show, vat_number: vat_number, email: 'good@youknow.id' }

        it_responds :bad_request, with_json: { success: false }
      end
    end

    describe 'when VIES VAT service is unavailable' do
    end

    describe 'when VAT database of the customer country is unavailable' do
    end

    describe 'when connection fails' do
      # SocketError
    end

    describe 'when request times out' do
    end

    describe 'when unknown problems happen' do
    end

    context 'good request' do
      let(:validation_result) { double 'Validation Result' }

      let(:mock_validation!) {
        is_expected.to receive(:validation).and_return validation_result
      }

      it 'responds with status 200' do
        mock_validation!
        expect(get_show.status).to be 200
      end

      it 'assigns the result of the validation to @valid' do
        mock_validation!
        get_show
        expect(assigns :valid).to eq validation_result
      end

      context 'with the default supplier' do
        it 'TODO' do
          pending
        end
      end

      context 'with a supplier' do
        it 'TODO' do
          pending
        end
      end
    end
  end
  
end
