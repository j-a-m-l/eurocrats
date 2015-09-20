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

  let(:example_supplier) { Eurocrats::Supplier.new }

  subject { described_class.new supplier: example_supplier }

  describe 'initialize' do
    context 'receiving and explicit supplier' do
      it 'uses it' do
        expect(described_class.new(supplier: example_supplier).supplier).to be example_supplier
      end

      context 'that is not a Taxable instance' do
        it 'raises an error' do
          expect { described_class.new supplier: 'NotTaxable' }.to raise_error TypeError, /taxable/i
        end
      end
    end

    context 'without receiving and explicit supplier' do
      context 'having a default supplier' do
        before(:each) { Eurocrats.default_supplier = example_supplier }

        it 'uses it' do
          expect(described_class.new.supplier).to be example_supplier
        end
      end

      context 'and without having a default supplier' do
        before(:each) { Eurocrats.class_variable_set :@@default_supplier, nil }

        it 'raises an error' do
          expect { described_class.new }.to raise_error ArgumentError, /supplier/i
        end
      end
    end

    # TODO other arguments
  end

  # TODO
  describe '#evidences' do
    it 'collects the customer evidences'
  end
  describe 'alias #evidence' do
  end

  describe '#[]' do
    context 'receiving an existent label' do
      let(:evidence) { Eurocrats::Evidence.from 'IT' }

      it 'returns the evidence with that label' do
        subject['yeah'] = evidence
        expect(subject['yeah']).to eq evidence
      end
    end

    context 'receiving an unknown label' do
      it 'raises an error' do
        expect { subject['lol'] }.to raise_error Eurocrats::InvalidEvidenceError, /evidence.*exist/i
      end
    end
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

  describe 'alias #favorable_evidences' do
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

    context 'having 2 pairs of non conflicting evidences' do
      it '' do
        pending
      end
    end

    # TODO more than 2 non conflicting

    # TODO minimum is more than 2
  end
  describe '#non_conflicting_location_evidences' do
  end

  describe 'alias #conflicts' do
    context 'having no evidence' do
      let(:evidences) { {} }

      it 'returns an empty Hash' do
        stub_evidences!
        expect(subject.conflicts).to eq({})
      end
    end

    context 'having only 1 evidence' do
      let(:evidences) { { 'one' => Eurocrats::Evidence.from('FR') } }

      it 'returns an empty Hash' do
        stub_evidences!
        expect(subject.conflicts).to eq({})
      end
    end

    context 'having 2 non conflicting evidences' do
      let(:evidences) { non_conflicting }

      it 'returns its Hash' do
        stub_evidences!
        expect(subject.conflicts).to eq({})
      end
    end

    context 'having 2 conflicting evidences' do
      let(:evidences) { conflicting }

      it 'returns an empty Hash' do
        stub_evidences!
        expect(subject.conflicts).to eq conflicting
      end
    end

    context 'having 2 non conflicting and 2 conflicting evidences' do
      let(:evidences) { non_conflicting.merge conflicting }

      it 'returns its Hash' do
        stub_evidences!
        expect(subject.conflicts).to eq conflicting
      end
    end

    context 'having 2 pairs of non conflicting evidences' do
      it '' do
        pending
      end
    end

    # TODO more than 2 non conflicting

    # TODO minimum is more than 2
  end
  describe '#conflicting_location_evidences' do
  end

  describe '#non_conflicting_location_evidences?' do
    describe 'receiving 2 existent evidence labels that refer to different countries' do
      subject { described_class.new supplier: example_supplier, evidences: conflicting }
      let(:labels) { conflicting.keys }

      it 'returns true' do
        expect(subject.non_conflicting_location_evidences? labels[0], labels[1]).to be false
      end
    end

    describe 'receiving 2 existent evidence labels that refer to the same countries' do
      subject { described_class.new supplier: example_supplier, evidences: non_conflicting }
      let(:labels) { non_conflicting.keys }

      it 'returns false' do
        expect(subject.non_conflicting_location_evidences? labels[0], labels[1]).to be true
      end
    end
  end
  describe 'alias #favorable_evidences?' do
  end
  describe 'alias #non_conflicting_evidences?' do
  end

  describe '#conflicting_location_evidences?' do
    describe 'receiving 2 existent evidence labels that refer to different countries' do
      subject { described_class.new supplier: example_supplier, evidences: conflicting }
      let(:labels) { conflicting.keys }

      it 'returns true' do
        expect(subject.conflicting_location_evidences? labels[0], labels[1]).to be true
      end
    end

    describe 'receiving 2 existent evidence labels that refer to the same countries' do
      subject { described_class.new supplier: example_supplier, evidences: non_conflicting }
      let(:labels) { non_conflicting.keys }

      it 'returns false' do
        expect(subject.conflicting_location_evidences? labels[0], labels[1]).to be false
      end
    end
  end
  describe 'alias #conflicting_evidences?' do
  end

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

  describe '#evidenced_country' do
    context 'without enough evidences' do
      it 'raises an error' do
        expect { subject.evidenced_country }.to raise_error Eurocrats::ConflictingEvidencesError, /conflict.*evidence/i
      end
    end

    # TODO minimum
    context 'with enough evidences' do
      subject { described_class.new supplier: example_supplier, evidences: non_conflicting }

      # TODO more cases, like 2 + 2
      it 'returns the country of the non conflicting evidences' do
        expect(subject.evidenced_country).to eq non_conflicting.values.first.country
      end
    end
  end
  describe 'alias #country' do
  end

  describe '#taxable_persons?' do
    let(:taxable) { Eurocrats::Customer.new vat_number: 'ES77777777Z' }
    let(:non_taxable) { Eurocrats::Customer.new }

    shared_examples :are_not_taxable do
      it 'returns true' do
        expect(subject.taxable_persons?).to be false
      end
    end

    context 'both supplier and customer are taxable' do
      subject { described_class.new supplier: taxable, customer: taxable }

      it 'returns true' do
        expect(subject.taxable_persons?).to be true
      end
    end

    context 'both supplier and customer are not taxable' do
      subject { described_class.new supplier: non_taxable, customer: non_taxable }

      include_examples :are_not_taxable
    end

    context 'supplier is taxable and customer is not' do
      subject { described_class.new supplier: taxable, customer: non_taxable }

      include_examples :are_not_taxable
    end

    context 'supplier is not taxable and customer is' do
      subject { described_class.new supplier: non_taxable, customer: taxable }

      include_examples :are_not_taxable
    end
  end
  describe 'alias #b2b?' do
  end

  describe '#validate_on_vies!' do
  end

  describe '#valid_vat_numbers?' do
    context 'VAT number are not validated' do
      it 'returns nil'
    end
  end

  describe '#should_vat_be_charged?' do

    shared_examples :should_be_charged do
      it 'then VAT should be charged' do
        expect(subject.should_vat_be_charged?).to be true
      end
    end

    shared_examples :should_not_be_charged do
      it 'then VAT should not be charged' do
        expect(subject.should_vat_be_charged?).to be false
      end
    end

    context 'without enough evidences' do
      it 'raises an error' do
        expect { subject.should_vat_be_charged? }.to raise_error Eurocrats::ConflictingEvidencesError, /conflict.*evidence/i
      end
    end

    context 'with enough evidences' do
      subject { described_class.new supplier: example_supplier, evidences: non_conflicting }

      context 'evidenced country is in the European Union' do
        before(:each) { allow(subject).to receive(:evidenced_country).and_return Eurocrats::Country['FR'] }

        context 'Supplier and Customer have both VAT numbers' do
          before(:each) { is_expected.to receive(:taxable_persons?).and_return true }

          context 'that are invalid' do
            before(:each) { is_expected.to receive(:valid_vat_numbers?).and_return false }

            include_examples :should_be_charged
          end

          context 'that are valid' do
            before(:each) { is_expected.to receive(:valid_vat_numbers?).and_return true }

            let(:pt_vat_number) { 'PT123456789' }
            let(:pt_vat_number2) { 'PT098765432' }
            let(:es_vat_number) { 'ES77777777Z' }

            before(:each) { subject.supplier.vat_number = pt_vat_number }

            context 'and belong to the same country' do
              before(:each) { subject.customer.vat_number = pt_vat_number2 }

              include_examples :should_be_charged
            end

            context 'and belong to different countries' do
              before(:each) { subject.customer.vat_number = es_vat_number }

              include_examples :should_not_be_charged
            end
          end
        end

        context 'Supplier and Customer do not have both VAT numbers' do
          include_examples :should_be_charged
        end
      end

      context 'evidenced country is not in the European Union' do
        before(:each) { is_expected.to receive(:evidenced_country).and_return Eurocrats::Country['AR'] }

        include_examples :should_not_be_charged
      end
    end

    # TODO country parameter
  end
  describe 'alias #charge_vat?' do
  end

  describe '#evidenced_vat_rates' do
    context 'without enough evidences' do
      it 'raises an error' do
        expect { subject.evidenced_vat_rates }.to raise_error Eurocrats::ConflictingEvidencesError, /conflict.*evidence/i
      end
    end

    context 'with enough evidences' do
      subject { described_class.new supplier: example_supplier, evidences: non_conflicting }

      it 'returns the VAT rate of the evidenced country' do
        expect(subject.evidenced_vat_rates).to eq subject.evidenced_country.vat_rates
      end
    end
  end
  describe 'alias #vat_rates' do
  end

  describe '#evidenced_vat' do
    context 'without enough evidences' do
      it 'raises an error' do
        expect { subject.evidenced_vat }.to raise_error Eurocrats::ConflictingEvidencesError, /conflict.*evidence/i
      end
    end

    context 'with enough evidences' do
      subject { described_class.new supplier: example_supplier, evidences: non_conflicting }

      let(:example_rates) { {'yeah' => 20, 'other' => 40} }

      context 'VAT should be charged' do
        before(:each) { expect(subject).to receive(:should_vat_be_charged?).and_return true }

        context 'without receiving any VAT rate' do
          it 'returns the value of the evidenced default VAT rate of the context' do
            expect(subject).to receive(:default_rate).and_return 'yeah'
            expect(subject).to receive(:evidenced_vat_rates).and_return example_rates
            expect(subject.evidenced_vat).to eq example_rates['yeah']
          end
        end

        context 'receiving a specific VAT rate' do
          it 'returns the value of the evidenced received VAT rate' do
            allow(subject).to receive(:default_rate).and_return 'other'
            expect(subject).to receive(:evidenced_vat_rates).and_return example_rates
            expect(subject.evidenced_vat 'yeah').to eq example_rates['yeah']
          end
        end
      end

      context 'VAT should not be charged' do
        before(:each) { expect(subject).to receive(:should_vat_be_charged?).and_return false }

        it 'returns zero' do
          expect(subject.evidenced_vat).to eq 0
        end
      end
    end
  end
  describe 'alias #vat' do
  end

  describe '#calculate_vat_for' do
    let(:amount) { 30 }

    context 'without enough evidences' do
      it 'raises an error' do
        expect { subject.calculate_vat_for amount }.to raise_error Eurocrats::ConflictingEvidencesError, /conflict.*evidence/i
      end
    end

    context 'with enough evidences' do
      subject { described_class.new supplier: example_supplier, evidences: non_conflicting }

      context 'without receiving any VAT rate' do
        it 'returns the VAT amount using the evidenced VAT of the default rate' do
          evidenced_vat = 20
          expect(subject).to receive(:evidenced_vat).with(nil).and_return evidenced_vat
          expect(subject.calculate_vat_for amount).to eq(amount * evidenced_vat / 100)
        end
      end

      context 'receiving a specific VAT rate' do
        it 'returns the VAT amount using the evidenced VAT of the received rate' do
          evidenced_vat = 20
          expect(subject).to receive(:evidenced_vat).with('lol').and_return evidenced_vat
          expect(subject.calculate_vat_for amount, vat_rate: 'lol').to eq(amount * evidenced_vat / 100)
        end
      end
    end
  end
  describe 'alias #vat_for' do
  end

  describe '#calculate_with_vat' do
    let(:amount) { 102 }

    context 'without enough evidences' do
      it 'raises an error' do
        expect { subject.calculate_with_vat amount }.to raise_error Eurocrats::ConflictingEvidencesError, /conflict.*evidence/i
      end
    end

    context 'with enough evidences' do
      subject { described_class.new supplier: example_supplier, evidences: non_conflicting }

      context 'without receiving any VAT rate' do
        it 'returns the total amount using the evidenced VAT of the default rate' do
          evidenced_vat = 20
          expect(subject).to receive(:evidenced_vat).with(nil).and_return evidenced_vat
          expect(subject.calculate_with_vat amount).to eq(amount * evidenced_vat / 100 + amount)
        end
      end

      context 'receiving a specific VAT rate' do
        it 'returns the total amount using the evidenced VAT of the received rate' do
          evidenced_vat = 20
          expect(subject).to receive(:evidenced_vat).with('lol').and_return evidenced_vat
          expect(subject.calculate_with_vat amount, vat_rate: 'lol').to eq(amount * evidenced_vat / 100 + amount)
        end
      end
    end
  end
  describe 'alias #with_vat' do
  end

  describe '#open' do
  end

  describe '#consumer' do
  end

  describe '#supplier' do
  end
  
end
