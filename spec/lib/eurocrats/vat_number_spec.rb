describe Eurocrats::VatNumber do

  # Google VAT number
  let(:customer_vat_number) { 'IE6388047V' }
  # eBay VAT number
  let(:requester_vat_number) { 'LU21416127' }

  let(:number) { customer_vat_number }

  describe '.seems_valid?' do
    it 'validates the VAT number syntax' do
      expect(Valvat::Syntax).to receive(:validate).with number
      described_class.seems_valid? number
    end
  end

  # TODO alias
  xdescribe '.is_valid?' do
    it 'validates the VAT number existence without a requester' do
      expect(described_class).to receive(:validate).with number, nil, 'detail option'
      described_class.is_valid? number, 'detail option'
    end
  end
  
  describe '.validate' do

    context 'without requester VAT number' do
      describe 'customer VAT number' do
        
        context 'exists' do
          xit '' do
            described_class.validate customer_vat_number
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

  describe '#==' do
    let(:subject) { described_class.new requester_vat_number }

    context 'same VAT number' do
      let(:other) { described_class.new requester_vat_number }

      it 'returns true (of course!)' do
        expect(subject == other).to be true
      end
    end

    context 'different VAT number' do
      let(:other) { described_class.new customer_vat_number }

      it 'returns false (of course!)' do
        expect(subject == other).to be false
      end
    end
  end

  describe '#initialize' do
    let(:ie_vat_number) { 'IE6388047V' }

    it 'establish the country code' do
      expect(described_class.new(ie_vat_number).country_code).to eq 'IE'
    end
  end

  # TODO attr_readers

  describe '#country_code_alpha2' do
  end

  describe '#validate_for' do
  end

end
