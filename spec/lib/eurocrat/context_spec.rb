describe Eurocrat::Context do

  describe 'initialize' do
  end

  describe '#<<' do
    it 'returns itself' do
      expect(subject << {}).to be subject
    end

    describe 'receiving a Hash' do
      let(:evidences) {
        { country: '' }
      }

      describe 'for each entry' do
        it 'checks that the value is an Alpha2 country code or raises an error'
        it 'checks that the value is an Alpha3 country code or raises an error'
        it 'checks that the value is an ISO country code or raises an error'

        describe 'adds a new evidence' do
          it 'with key as the evidence name' do
            subject.evidences
          end

          it 'with its country, as Alpha2 code, as the evidence value'
        end
      end
    end

    describe 'receiving a VatNumber object' do
      it 'changes the customer VAT number'

      describe 'adds a new evidence' do
        it 'with "vat_number" as the evidence name'
        it 'with its country as the evidence value'
      end
    end

    # TODO
    describe 'receiving an Address object' do
    end

    describe 'receiving other than Hash or VatNumber object' do
      it 'raises an error' do
        expect { subject << 'lol' }.to raise_error ArgumentError, /evidence/i
      end
    end
  end

  describe '#enough?' do
  end

  describe '#with_vat' do
  end

  describe '#evidences' do
  end
  describe '#evidences=' do
  end


  describe '#consumer' do
  end
  describe '#consumer=' do
  end

  describe '#vat_number' do
  end
  describe '#vat_number=' do
  end


  describe '#e_commerce!' do
  end

  describe '#vat_rates' do
  end

  describe '#conflictives' do
  end
  
end
