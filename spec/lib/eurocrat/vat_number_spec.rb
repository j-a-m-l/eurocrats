describe Eurocrat::VatNumber do

  # Google VAT number
  let(:customer_vat_number) { 'IE6388047V' }
  # eBay VAT number
  let(:requester_vat_number) { 'LU21416127' }
  
  describe '.check' do

    context 'without requester VAT number' do
      describe 'customer VAT number' do
        
        context 'exists' do
          it '' do
            described_class.check customer_vat_number
            require 'byebug'; byebug;
          end
        end
        context "doesn't exist" do
        end

      end
    end

    context 'with requester VAT number' do
    end
    
  end

end
