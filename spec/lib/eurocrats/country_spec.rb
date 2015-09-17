describe Eurocrats::Country do

  let(:eu_country) { described_class['DE'] }

  # TODO test alias
  describe '.code_to_alpha2' do
    let(:exception) { Eurocrats::InvalidCountryCodeError }

    # TODO refactor these tests
    # TODO error message

    context 'receiving an integer that is not a valid ISO 3166-1 numeric' do
      it 'raises an error' do
        expect { described_class.code_to_alpha2 999 }.to raise_error exception
      end
    end

    context 'receiving an integer that is a valid ISO 3166-1 numeric' do
      it 'returns its corresponding ISO 3166-1 alpha-2' do
        expect(described_class.code_to_alpha2 724).to eq 'ES'
      end
    end

    context 'receiving a 3-character string that is not a valid ISO 3166-1 numeric' do
      it 'raises an error' do
        expect { described_class.code_to_alpha2 '999' }.to raise_error exception
      end
    end

    context 'receiving a 3-character string that is a valid ISO 3166-1 numeric' do
      it 'returns its corresponding ISO 3166-1 alpha-2' do
        expect(described_class.code_to_alpha2 '724').to eq 'ES'
      end
    end

    context 'receiving a 3-character string that is not a valid ISO 3166-1 alpha-3' do
      it 'raises an error' do
        expect { described_class.code_to_alpha2 'XXX' }.to raise_error exception
      end
    end

    context 'receiving a 3-character string that is a valid ISO 3166-1 alpha-3' do
      it 'returns its corresponding ISO 3166-1 alpha-2' do
        expect(described_class.code_to_alpha2 'USA').to eq 'US'
      end
    end

    context 'receiving a 2-character string that is not a valid ISO 3166-1 alpha-2' do
      it 'raises an error' do
        expect { described_class.code_to_alpha2 'XX' }.to raise_error exception
      end
    end

    context 'receiving a 2-character string that is a valid ISO 3166-1 alpha-2' do
      it 'returns it' do
        expect(described_class.code_to_alpha2 'FR').to eq 'FR'
      end
    end

    context 'receiving other thing' do
      it 'raises an error' do
        expect { described_class.code_to_alpha2 'example' }.to raise_error exception
      end
    end
  end
  describe '.to_alpha2' do
  end

  describe '.vat_rates_in' do
    context 'receiving an Eurocrats::Country instance' do
      it 'returns the VAT rates of the country' do
        expect(described_class.vat_rates_in eu_country).to eq eu_country.vat_rates
      end
    end

    context 'receiving an ISO3166::Country instance' do
      let(:eu_country) { ISO3166::Country['DE'] }

      it 'returns the VAT rates of the country' do
        expect(described_class.vat_rates_in eu_country).to eq eu_country.vat_rates
      end
    end

    context 'receiving an ISO 3166-2 alpha-2 country code' do
      it 'returns the VAT rates of the country' do
        expect(described_class.vat_rates_in eu_country.alpha2).to eq eu_country.vat_rates
      end
    end

    # TODO more country codes
  end

  describe '.in_european_union?' do
    let(:is_eu_member) { double 'Value of :in_eu?' }

    context 'receiving an Eurocrats::Country instance' do
      it 'returns if the country belongs to the European Union' do
        expect(eu_country).to receive(:in_eu?).and_return is_eu_member
        expect(described_class.in_european_union? eu_country).to eq is_eu_member
      end
    end

    context 'receiving an ISO3166::Country instance' do
      let(:eu_country) { ISO3166::Country['DE'] }

      it 'returns if the country belongs to the European Union' do
        country_double = double in_eu?: is_eu_member
        expect(described_class).to receive(:[]).with(eu_country.alpha2).and_return country_double
        expect(described_class.in_european_union? eu_country).to eq is_eu_member
      end
    end

    context 'receiving an ISO 3166-2 alpha-2 country code' do
      it 'returns if the country belongs to the European Union' do
        country_double = double in_eu?: is_eu_member
        expect(described_class).to receive(:[]).with(eu_country.alpha2).and_return(country_double).at_least 1
        expect(described_class.in_european_union? eu_country.alpha2).to eq is_eu_member
      end
    end

    # TODO more country codes
  end
  describe '.in_eu?' do
  end

  describe '#code' do
  end
  describe '#alpha2_code' do
  end

end
