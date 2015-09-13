describe Eurocrats::Vies::Validation do

  let(:valid_a) { 'IE6388047V' }
  let(:valid_b) { 'LU21416127' }
  let(:invalid_a) { 'LU121' }
  let(:invalid_b) { 'IE112' }
  let(:vn_a) { Eurocrats::VatNumber.new valid_a }
  let(:vn_b) { Eurocrats::VatNumber.new valid_b }

  let(:request_date) { Date.today }
  let(:response_b) {
    {
      request_date: request_date,
      country_code: 'LU',
      vat_number: '21416127',
      name: 'EBAY EUROPE S.A R.L.',
      address: '22, BOULEVARD ROYAL\nL-2449  LUXEMBOURG',
    }
  }

  describe '#initialize' do
    context 'receiving VatNumber objects' do
      it 'establish its VAT numbers' do
        subject = described_class.new vn_a, vn_b

        expect(subject.requester_vat_number).to be vn_a
        expect(subject.vat_number).to be vn_b
      end

      context 'if they are the same' do
        xit 'raises an error' do
          expect { described_class.new vn_a, vn_a }.to raise_error
        end
      end
    end
    
    context 'receiving VAT numbers (strings)' do
      context 'if they are not valid' do
        it 'and raises an error' do
          expect { described_class.new valid_a, invalid_a }.to raise_error
          expect { described_class.new invalid_a, valid_a }.to raise_error
          expect { described_class.new invalid_a, invalid_b }.to raise_error
        end
      end

      context 'if they are valid' do
        it 'converts them to VatNumber objects and establish them as the VAT numbers' do
          subject = described_class.new valid_a, valid_b

          expect(subject.requester_vat_number).to be_a Eurocrats::VatNumber
          expect(subject.vat_number).to be_a Eurocrats::VatNumber

          expect(subject.requester_vat_number.to_s).to eq valid_a
          expect(subject.vat_number.to_s).to eq valid_b
        end
      end

      context 'if they are the same' do
        xit 'raises an error' do
          expect { described_class.new valid_a, valid_a }.to raise_error
        end
      end
    end
  end

  describe '#request' do
    subject { described_class.new valid_a, valid_b }

    let(:stub_response!) {
      stub = expect(Eurocrats::Vies).to receive(:validate_vat_number)
      stub.with(subject.vat_number, subject.requester_vat_number, true)
      stub.and_return response_b
    }

    context 'success request' do
      it 'assigns the request date response property' do
        stub_response!
        subject.request
        expect(subject.request_date).to eq response_b[:request_date]
      end

      # TODO if exists
      it 'assigns the name response property' do
        stub_response!
        subject.request
        expect(subject.name).to eq response_b[:name]
      end

      # TODO if exists
      it 'assigns the address response property' do
        stub_response!
        subject.request
        expect(subject.address).to eq response_b[:address]
      end
    end

    context 'inexistent VAT numbers' do
    end

    context 'VIES error' do
    end

    context 'connection error' do
    end
  end

  describe '#request!' do
    subject { described_class.new valid_a, valid_b }

    let(:stub_response!) {
      stub = expect(Eurocrats::Vies).to receive(:validate_vat_number!)
      stub.with(subject.vat_number, subject.requester_vat_number, true)
      stub.and_return response_b
    }

    context 'success request' do
      it 'assigns the request date response property' do
        stub_response!
        subject.request!
        expect(subject.request_date).to eq response_b[:request_date]
      end

      # TODO if exists
      it 'assigns the name response property' do
        stub_response!
        subject.request!
        expect(subject.name).to eq response_b[:name]
      end

      # TODO if exists
      it 'assigns the address response property' do
        stub_response!
        subject.request!
        expect(subject.address).to eq response_b[:address]
      end
    end

    context 'inexistent VAT numbers' do
    end

    context 'VIES error' do
    end

    context 'connection error' do
    end
  end

  describe '#success?' do
    context 'with a request date' do
      it 'returns true'
    end

    context 'without a request date' do
      it 'returns false'
    end
  end

end
