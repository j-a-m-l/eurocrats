describe Eurocrat::Context do

  let(:conflicting) {
    {
      'one' => Eurocrat::Evidence.from('AT'),
      'two' => Eurocrat::Evidence.from('MT'),
    }
  }

  let(:non_conflicting) {
    {
      'non_one' => Eurocrat::Evidence.from('CY'),
      'non_two' => Eurocrat::Evidence.from('CY'),
    }
  }

  let(:stub_evidences!) {
    expect(subject).to receive(:evidences).and_return(evidences).at_least(:once)
  }

  describe 'initialize' do
  end

  describe '#evidences' do
    it 'collects the customer evidences'
  end

  describe '#[]' do
  end

  describe '#[]=' do
    let(:label) { 'declared.country_code' }

    context 'receiving an Evidence' do
      let(:source) { Eurocrat::Evidence.from 'IT' }

      it 'adds it as evidence' do
        subject[label] = source
        expect(subject.evidences[label]).to be source
      end
    end

    context 'receiving other Object' do
      let(:source) { 'DE' }

      it 'instantiates a new Evidence using that object as source and adds it as evidence' do
        subject[label] = source
        expect(subject.evidences[label]).to be_a Eurocrat::Evidence
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
      let(:evidences) { { 'one' => Eurocrat::Evidence.from('FR') } }

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

  describe '#evidenced_country_code' do
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

  describe '#vat_for' do
  end

  describe '#add_vat_tovat' do
  end

  describe '#open' do
  end

  describe '#consumer' do
  end
  describe '#supplier' do
  end
  
end
