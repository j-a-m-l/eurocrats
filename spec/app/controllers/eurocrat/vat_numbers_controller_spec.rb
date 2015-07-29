describe Eurocrat::VatNumbersController do

  routes { Eurocrat::Engine.routes }

  describe '#show' do
    let(:vat_number) { 'EX4MP13' }

    context 'bad request' do
      describe 'without VAT number' do
        before(:each) { get :show, {} }

        it_responds :bad_request, with_json: { success: false }
      end

      describe 'with unpermitted parameters' do
        before(:each) { get :show, vat_number: vat_number, email: 'good@youknow.id' }

        it_responds :bad_request, with_json: { success: false }
      end
    end

    context 'VAT number seems invalid' do
    end

    context 'VAT number seems valid' do
      before(:each) { get :show, { email: email } }

      context 'email exists' do
        let(:email) { create(:predictable_account, :confirmed)[:email] }

        it_responds :bad_request, with_json: { success: false }
      end

      context "email doesn't exist" do
        let(:email) { attributes_for(:account, :random, :confirmed)[:email] }

        it_responds :success, with_json: { success: true }
      end
    end
    
  end
  
end
