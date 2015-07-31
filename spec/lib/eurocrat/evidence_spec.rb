describe Eurocrat::Evidence do
  let(:country_code) { 'country code' }

  describe '.from_country_code' do
    context 'receiving a country code' do
      it "instantiates an #{described_class.name} with it" do
        expect(described_class).to receive(:new).with country_code, country_code
        described_class.from_country_code country_code
      end
    end
  end

  describe '.from_hash' do
    context 'receiving a Hash that' do
      # TODO test string and symbol
      # TODO test order | priority

      described_class::COUNTRY_CODE_KEYS.each do |key|
        context "has the #{key} key" do
          let(:source) { { :a_key => 'example', key => country_code } }

          it "instantiates an #{described_class.name} with it" do
            expect(described_class).to receive(:new).with country_code, source
            described_class.from_hash source
          end
        end
      end    
    end

    context 'receiving a Hash without a known country code key' do
      let(:source) { { :a_key => 'example', 'other' => country_code } }

      it 'raises an error' do
        expect { described_class.from_hash source }.to raise_error
      end
    end
  end

  describe '.from_object' do
    context 'receiving an Object that' do
      # TODO test order | priority

      described_class::COUNTRY_CODE_KEYS.each do |key|
        context "has the #{key} method" do
          let(:source) { Struct.new(:a_key, key.to_sym).new 'example', country_code }

          it "instantiates an #{described_class.name} with it" do
            expect(described_class).to receive(:new).with country_code, source
            described_class.from_object source
          end
        end
      end    
    end

    context 'receiving an Object without a known country code method' do
      let(:source) { Struct.new(:a_key, :unknown).new 'example', country_code }

      it 'raises an error' do
        expect { described_class.from_object source }.to raise_error
      end
    end
  end

  describe '.from' do
    
  end

  describe '#initialize' do

    let(:country_code) { 'CH' }
    let(:data) { 'example data' }

    it 'establish the country code' do
      expect(described_class.new(country_code, data).country_code).to eq country_code
    end

    it 'establish the data' do
      expect(described_class.new(country_code, data).data).to be data
    end

    it 'tries to convert the country_code parameter to ISO 3166-1 alpha-2' do
      expect(Eurocrat::Country).to receive(:to_alpha2).with country_code
      described_class.new country_code, data
    end
  end

  # TODO country_code reader
  # TODO data reader

end
