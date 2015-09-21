describe Eurocrats::Evidence do

  let(:country_code) { 'IT' }

  subject { described_class.new country_code, 'example' }

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
        expect { described_class.from_hash source }.to raise_error Eurocrats::InvalidCountryCodeError, /country.*key/
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
        expect { described_class.from_object source }.to raise_error Eurocrats::InvalidCountryCodeError, /country.*method/
      end
    end
  end

  # TODO
  describe '.from' do
  end

  describe '#initialize' do
    let(:source) { 'example source' }

    it 'establish the country code' do
      expect(described_class.new(country_code, source).country_code).to eq country_code
    end

    it 'establish the source' do
      expect(described_class.new(country_code, source).source).to be source
    end

    it 'tries to convert the country_code parameter to ISO 3166-1 alpha-2' do
      expect(Eurocrats::Country).to receive(:to_alpha2).with country_code
      described_class.new country_code, source
    end
  end

  # TODO country_code reader
  # TODO data reader
  
  describe '#country' do
    let(:country) { ISO3166::Country[country_code] }

    it 'returns the Country' do
      expect(subject.country).to be_a ISO3166::Country
      expect(subject.country).to eq country
    end
  end
  
  describe '#vat_rates' do
    let(:vat_rates) { ISO3166::Country[country_code].vat_rates }

    context 'country applies VAT' do
      it 'returns the VAT rates of the country' do
        expect(subject.vat_rates).to be_a Hash
        expect(subject.vat_rates).to eq vat_rates
      end
    end

    context 'country do not apply VAT' do
      let(:country_code) { 'MX' }

      it 'returns Hash or nil? Or raises?' do
        pending
      end
    end
  end

  describe '#vat_for_current_context' do
    context 'belonging to a Context' do
      let(:context_double) {
        instance_double Eurocrats::Context
      }

      before(:each) { subject.context = context_double }

      it 'checks if the VAT should be charged' do
        expect(context_double).to receive(:should_vat_be_charged?)
        subject.vat_for_current_context
      end

      context 'VAT should not be charged' do
        it 'returns zero' do
          expect(context_double).to receive(:should_vat_be_charged?).and_return false
          expect(subject.vat_for_current_context).to eq 0
        end
      end

      context 'VAT should be charged' do
        let(:default_rate_name) { 'yeah' }
        let(:example_rates) { { default_rate_name => BigDecimal(0.20, 2) } }

        describe 'without receiving any specific rate' do
          it 'returns the VAT for the default rate of the Context' do
            expect(context_double).to receive(:should_vat_be_charged?).and_return true
            expect(context_double).to receive(:vat_rate).and_return default_rate_name
            expect(subject).to receive(:vat_rates).and_return example_rates

            expect(subject.vat_for_current_context).to eq example_rates[default_rate_name]
          end
        end

        describe 'receiving a specific rate' do
        end
      end
    end

    context 'not belonging to any Context' do
      it 'raises an error' do
        expect { subject.vat_for_current_context }.to raise_error Eurocrats::EvidenceWithoutContextError, /evidence.*context/i
      end
    end
  end
  describe 'alias #vat' do
  end

  describe '#calculate_vat_for' do
    let(:amount) { 20 }
    let(:example_rate) { 0.2 }

    context 'not belonging to any Context' do
      it 'raises an error' do
        expect { subject.calculate_vat_for amount }.to raise_error Eurocrats::EvidenceWithoutContextError, /evidence.*context/i
      end
    end

    context 'belonging to a Context' do
      describe 'without receiving any specific rate' do
        it 'uses the one from the context and returns the VAT for the amount parameter' do
          expect(subject).to receive(:vat_for_current_context).and_return example_rate
          expect(subject.calculate_vat_for amount).to be amount * example_rate
        end
      end

      describe 'receiving a specific rate' do
      end
    end
  end
  describe 'alias #vat_for' do
  end

  describe '#calculate_with_vat' do
    let(:amount) { 102 }

    context 'not belonging to any Context' do
      it 'raises an error' do
        expect { subject.calculate_with_vat amount }.to raise_error Eurocrats::EvidenceWithoutContextError, /evidence.*context/i
      end
    end

    context 'belonging to a Context' do

      context 'without receiving any VAT rate' do
        it 'uses the one from the context and returns the total amount' do
          vat = 20
          expect(subject).to receive(:vat_for_current_context).and_return vat
          expect(subject.calculate_with_vat amount).to eq(amount + amount * vat)
        end
      end
    end
  end
  describe 'alias #with_vat' do
  end

end
