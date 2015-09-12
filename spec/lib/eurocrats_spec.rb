describe Eurocrats do

  describe '.default_supplier' do
    it 'does not have an initial value' do
      expect(described_class.default_supplier).to be nil
    end
  end

  describe '.default_supplier=' do
    it 'changes the default supplier' do
      supplier = double 'Supplier'
      described_class.default_supplier = supplier
      expect(described_class.default_supplier).to be supplier
    end
  end

end
