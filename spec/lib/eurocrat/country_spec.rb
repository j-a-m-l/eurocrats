describe Eurocrat::Country do

  describe '.country_code_to_alpha2' do
    let(:exception) { Eurocrat::InvalidCountryCodeError }

    context 'receiving an integer that is not a valid ISO 3166-1 numeric' do
      it 'raises an error' do
        expect { described_class.country_code_to_alpha2 999 }.to raise_error exception
      end
    end

    context 'receiving an integer that is a valid ISO 3166-1 numeric' do
      it 'returns its corresponding ISO 3166-1 alpha-2' do
        expect(described_class.country_code_to_alpha2 724).to eq 'ES'
      end
    end

    context 'receiving a 3-character string that is not a valid ISO 3166-1 numeric' do
      it 'raises an error' do
        expect { described_class.country_code_to_alpha2 '999' }.to raise_error exception
      end
    end

    context 'receiving a 3-character string that is a valid ISO 3166-1 numeric' do
      it 'returns its corresponding ISO 3166-1 alpha-2' do
        expect(described_class.country_code_to_alpha2 '724').to eq 'ES'
      end
    end

    context 'receiving a 3-character string that is not a valid ISO 3166-1 alpha-3' do
      it 'raises an error' do
        expect { described_class.country_code_to_alpha2 'XXX' }.to raise_error exception
      end
    end

    context 'receiving a 3-character string that is a valid ISO 3166-1 alpha-3' do
      it 'returns its corresponding ISO 3166-1 alpha-2' do
        expect(described_class.country_code_to_alpha2 'USA').to eq 'US'
      end
    end

    context 'receiving a 2-character string that is not a valid ISO 3166-1 alpha-2' do
      it 'raises an error' do
        expect { described_class.country_code_to_alpha2 'XX' }.to raise_error exception
      end
    end

    context 'receiving a 2-character string that is a valid ISO 3166-1 alpha-2' do
      it 'returns it' do
        expect(described_class.country_code_to_alpha2 'FR').to eq 'FR'
      end
    end

    context 'receiving other thing' do
      it 'raises an error' do
        expect { described_class.country_code_to_alpha2 'example' }.to raise_error exception
      end
    end

  end

end
