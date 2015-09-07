describe Eurocrats::Taxable do

  xdescribe '#vat_number=' do
    shared_examples :returns_vat_number_object do
      it 'returns the VatNumber object' do
        expect(subject.vat_number = vat_number).to be_a Eurocrats::VatNumber
      end
    end

    context 'receiving a VatNumber object' do
      let(:vat_number) { Eurocrats::VatNumber.new '' }

      it 'assigns it to the Customer' do
        subject.vat_number = vat_number
        expect(subject.vat_number).to eq vat_number
      end
      
      include_examples :returns_vat_number_object
    end

    context 'receiving other Object' do
      let(:vat_number) { 'DK1212' }

      it 'instantiates a VatNumber object and assigns it to the Customer' do
        subject.vat_number = vat_number
        expect(subject.vat_number).to be_a Eurocrats::VatNumber
        expect(subject.vat_number.source).to eq vat_number
      end

      include_examples :returns_vat_number_object
    end
  end

  describe '#taxable?' do
  end
  
end
