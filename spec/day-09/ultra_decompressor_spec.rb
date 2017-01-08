require 'yaml'
require 'day-09/ultra_decompressor'

RSpec.describe UltraDecompressor do
  describe '#decompress' do
    it 'decompresses compression markers found within compression markers' do
      ultra_decompressor = described_class.new('X(8x2)(3x3)ABCY')
      expect(ultra_decompressor.decompressed_length).to eql(20)
    end

    it 'passes this test too' do
      ultra = described_class.new('(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN')
      expect(ultra.decompressed_length).to eql(445)
    end
  end

  context 'with Advent Code input' do
    it 'solves the puzzle' do
      ultra = described_class.new(YAML.load_file('./spec/fixtures/decompressor_input.txt'))
      expect(ultra.decompressed_length).to eql(11052855125)
    end
  end
end
