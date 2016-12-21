require 'day-03/triangle'

RSpec.describe Triangle do
  describe '#possible?' do
    context 'with valid triangle measurements' do
      it 'creates a possible triangle' do
        expect(Triangle.new([3, 4, 5]).possible?).to eql(true)
      end
    end

    context "with sides that don't add up right" do
      it 'creates a triangle that is not possible' do
        expect(Triangle.new([5, 10, 25]).possible?).to eql(false)
      end
    end
  end
end
