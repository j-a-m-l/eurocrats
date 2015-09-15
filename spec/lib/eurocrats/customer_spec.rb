describe Eurocrats::Customer do

  describe '#initialize' do
    describe 'data parameter' do
      context 'has a `vat_number` key' do
        let(:data) { { vat_number: 'PT000000000' } }

        it 'assigns it to the VAT number' do
          expect(described_class.new(data).vat_number).to eq data[:vat_number]
        end

        context 'VAT number is invalid' do
          let(:data) { { vat_number: 'example' } }

          it 'raises error' do
            expect { described_class.new data }.to raise_error Eurocrats::InvalidVatNumberError
          end
        end
      end
    end
  end

end
