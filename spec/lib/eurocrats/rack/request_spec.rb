describe Eurocrats::Rack::Request do

  class MockRequest < Rack::Request
    include Eurocrats::Rack::Request

    def initialize ip=''
      super('REMOTE_ADDR' => ip)
    end
  end

  describe Eurocrats do
    describe '.test_location' do
    end

    describe '.test_location=' do
    end
  end

  describe '#eurocrats' do
    before(:each) { Eurocrats.default_supplier = {} }

    let(:evidence_country_code) { subject.eurocrats['ip_location'].country_code }

    it 'returns a new Context the first time is called'

    it 'does not instantiates a new Context every time is called'

    context 'request IP is not loopback' do
      subject { MockRequest.new '27.10.0.1' }

      it 'uses `safe_location` for setting the "ip_location" evidence' do
        country_code = 'RU'
        expect(subject).to receive(:safe_location).and_return country_code
        expect(evidence_country_code).to eq country_code
      end
    end

    context 'request IP is loopback' do
      subject { MockRequest.new '127.0.0.1' }

      context 'with `Eurocrats.test_location`' do
        before(:each) { Eurocrats.test_location = { country_code: 'CA' } }

        it 'uses it for setting the "ip_location" evidence' do
          expect(evidence_country_code).to eq Eurocrats.test_location[:country_code]
        end
      end

      context 'without `Eurocrats.test_location`' do
        before(:each) { Eurocrats.test_location = nil }

        it 'raises an error' do
          expect { subject.eurocrats }.to raise_error Eurocrats::TestLocationError, /test.*location/i
        end
      end
    end
  end
  
end
