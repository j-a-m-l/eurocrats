describe Eurocrat::Customer do

  let(:ip) { '46.19.37.108' }

  subject { described_class.new ip }
  
  describe '#locate' do
    it 'it' do
      subject.locate
    end
  end

end
