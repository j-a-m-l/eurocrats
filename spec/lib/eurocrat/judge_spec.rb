describe Eurocrat::Judge do

  let(:conflicting) {
    {
      'one' => Eurocrat::Evidence.from('AT'),
      'two' => Eurocrat::Evidence.from('CY'),
    }
  }

  let(:non_conflicting) {
    {
      'one' => Eurocrat::Evidence.from('CY'),
      'two' => Eurocrat::Evidence.from('CY'),
    }
  }

  describe '#verdict' do
    let(:customer) { Eurocrat::Customer.new }

    context "customer doesn't have evidences" do
      it 'returns false' do
        expect(subject.verdict customer).to be false
      end
    end

    context 'customer has conflicting evidences' do
      it 'returns false' do
        expect(customer).to receive(:evidences).at_least(:once).and_return conflicting
        expect(subject.verdict customer).to be false
      end
    end

    context 'customer has non conflicting evidences' do
      it 'returns true' do
        expect(customer).to receive(:evidences).at_least(:once).and_return non_conflicting
        expect(subject.verdict customer).to be true
      end
    end
  end

  describe '#conflicts' do
    context 'receiving an empty Hash of evidences' do
      let(:evidences) { {} }

      it 'returns another' do
        expect(subject.conflicts evidences).to_not be evidences
        expect(subject.conflicts evidences).to eq({})
      end
    end

    context 'receiving a Hash with only 1 evidence' do
      let(:evidences) { { 'one' => Eurocrat::Evidence.from('FR') } }

      it 'returns it' do
        expect(subject.conflicts evidences).to eq evidences
      end
    end

    context 'receiving a Hash with 2 non conflicting evidences' do
      it 'returns an empty Hash' do
        expect(subject.conflicts non_conflicting).to eq({})
      end
    end

    context 'receiving a Hash with more than 2 non conflicting evidences' do
      xit 'returns an empty Hash' do
        expect(subject.conflicts non_conflicting).to eq({})
      end
    end
  end

end
