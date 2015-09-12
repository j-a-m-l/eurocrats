describe Eurocrats::Context do

  let(:conflicting) {
    {
      'one' => Eurocrats::Evidence.from('AT'),
      'two' => Eurocrats::Evidence.from('MT'),
    }
  }

  let(:non_conflicting) {
    {
      'non_one' => Eurocrats::Evidence.from('CY'),
      'non_two' => Eurocrats::Evidence.from('CY'),
    }
  }

  let(:stub_evidences!) {
    expect(subject).to receive(:evidences).and_return(evidences).at_least(:once)
  }

  subject { described_class.new Eurocrats::Supplier.new }

  describe 'initialize' do

    let(:example_supplier) { Eurocrats::Supplier.new }

    context 'receiving and explicit supplier' do
      it 'uses it' do
        expect(described_class.new(example_supplier).supplier).to be example_supplier
      end

      context 'that is not a Taxable instance' do
        it 'raises an error' do
          expect { described_class.new 'NotTaxable' }.to raise_error TypeError, /taxable/i
        end
      end
    end

    context 'without receiving and explicit supplier' do
      context 'having a default supplier' do
        it 'uses it' do
          Eurocrats.default_supplier = example_supplier
          expect(described_class.new.supplier).to be example_supplier
        end
      end

      context 'and without having a default supplier' do
        it 'raises an error' do
          expect { described_class.new }.to raise_error TypeError, /taxable/i
        end
      end
    end
  end

  describe '#evidences' do
    it 'collects the customer evidences'
  end

  describe '#[]' do
  end

  describe '#[]=' do
    let(:label) { 'declared.country_code' }

    context 'receiving an Evidence' do
      let(:source) { Eurocrats::Evidence.from 'IT' }

      it 'adds it as evidence' do
        subject[label] = source
        expect(subject.evidences[label]).to be source
      end
    end

    context 'receiving other Object' do
      let(:source) { 'DE' }

      it 'instantiates a new Evidence using that object as source and adds it as evidence' do
        subject[label] = source
        expect(subject.evidences[label]).to be_a Eurocrats::Evidence
        expect(subject.evidences[label].source).to eq source
      end
    end
  end

  # TODO alias
  describe '#favorable_evidences' do
    context 'having no evidence' do
      let(:evidences) { {} }

      it 'returns an empty Hash' do
        stub_evidences!
        expect(subject.favorable_evidences).to eq({})
      end
    end

    context 'having only 1 evidence' do
      let(:evidences) { { 'one' => Eurocrats::Evidence.from('FR') } }

      it 'returns its Hash' do
        stub_evidences!
        expect(subject.favorable_evidences).to eq evidences
      end
    end

    context 'having 2 non conflicting evidences' do
      let(:evidences) { non_conflicting }

      it 'returns its Hash' do
        stub_evidences!
        expect(subject.favorable_evidences).to eq non_conflicting
      end
    end

    context 'having 2 conflicting evidences' do
      let(:evidences) { conflicting }

      it 'returns an empty Hash' do
        stub_evidences!
        expect(subject.favorable_evidences).to eq({})
      end
    end

    context 'having 2 non conflicting and 2 conflicting evidences' do
      let(:evidences) { non_conflicting.merge conflicting }

      it 'returns its Hash' do
        stub_evidences!
        expect(subject.favorable_evidences).to eq non_conflicting
      end
    end

    # TODO more than 2
    # TODO 2 + 2 different non_conflicting
  end

  # TODO alias
  describe '#conflicting_evidences' do
  end

  # TODO alias
  describe '#enough_evidences?' do
    context 'b2b' do
      let(:mock_b2b!) {
      }

      context 'valid VAT numbers' do
        it 'returns true'
      end

      context 'without valid VAT numbers' do
        it 'checks the location evidences'
      end
    end

    context 'with non conflicting evidences' do
      let(:evidences) { non_conflicting }

      it 'returns true' do
        stub_evidences!
        expect(subject.enough_evidences?).to be true
      end
    end

    context 'without non conflicting evidences' do
      let(:evidences) { conflicting }

      it 'returns false' do
        stub_evidences!
        expect(subject.enough_evidences?).to be false
      end
    end
  end

  # TODO alias
  describe '#evidenced_country_code' do
  end

  describe '#country_code_of' do
  end

  # TODO alias
  describe '#taxables?' do
  end

  describe '#validate_on_vies!' do
  end

  describe '#valid_vat_numbers?' do
    context 'VAT number are not validated' do
      it 'returns nil'
    end
  end

  describe '#should_vat_be_charged?' do
  end

  describe '#vat_rates' do
  end

  describe '#vat_rates_in' do
  end

  describe '#vat_rates_of' do
  end

  describe '#vat_for' do
  end

  describe '#with_vat' do
  end

  describe '#open' do
  end

  describe '#consumer' do
  end
  describe '#supplier' do
  end
  
end
