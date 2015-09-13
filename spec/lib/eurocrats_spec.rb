describe Eurocrats do

  describe '.default_supplier' do
    # TODO Test order...
    xit 'does not have an initial value' do
      expect(described_class.default_supplier).to be nil
    end
  end

  describe '.default_supplier=' do
    context 'receiving a Supplier instance' do
      it 'changes the default supplier' do
        supplier = described_class::Supplier.new
        described_class.default_supplier = supplier
        expect(described_class.default_supplier).to be supplier
      end
    end

    context 'receiving a Hash' do
      let(:vat_number) { 'LU11111111' }

      it 'coverts it to Supplier and sets it as the default supplier' do
        described_class.default_supplier = {}
        expect(described_class.default_supplier).to be_a described_class::Supplier
      end

      context 'with symbol key `:vat_number`' do
        it 'uses as the supplier VAT number' do
          described_class.default_supplier = { vat_number: vat_number }
          expect(described_class.default_supplier.vat_number).to eq described_class::VatNumber.new(vat_number)
        end
      end

      context 'with tring key `vat_number`' do
        it 'uses as the supplier VAT number' do
          described_class.default_supplier = { 'vat_number' => vat_number }
          expect(described_class.default_supplier.vat_number).to eq described_class::VatNumber.new(vat_number)
        end
      end
    end

    context 'receiving other thing' do
      it 'raises an error' do
        expect { described_class.default_supplier = 'lol' }.to raise_error ArgumentError, /supplier/i
      end
    end
  end

end
