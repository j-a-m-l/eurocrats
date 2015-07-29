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
          end
        end

        context "doesn't exist" do
        end

      end
    end

    context 'with requester VAT number' do
    end

    context 'with detail' do
    end

    describe 'when VIES VAT service is unavailable' do
    end

    describe 'when VAT database of the customer country is unavailable' do
    end

    describe 'when request times out' do
    end

    describe 'when unknown problems happen' do
    end
    
  end

end
