require 'yaml'
require 'day-09/decompressor'

RSpec.describe Decompressor do
  describe '#decompressed_text' do
    it 'returns a string exactly if it contains no compression markers' do
      decompressor = described_class.new('ADVENT')
      expect(decompressor.decompressed_text).to eql('ADVENT')
    end

    it 'expands a string by dimension markers' do
      decompressor = described_class.new('A(1x5)BC')
      expect(decompressor.decompressed_text).to eql('ABBBBBC')
    end

    it 'copies text longer than a character' do
      decompressor = described_class.new('(3x3)XYZ')
      expect(decompressor.decompressed_text).to eql('XYZXYZXYZ')
    end

    it 'expands text if it finds more than one marker' do
      decompressor = described_class.new('A(2x2)BCD(2x2)EFG')
      expect(decompressor.decompressed_text).to eql('ABCBCDEFEFG')
    end

    it 'skips over strings that look like markers if they are already marked' do
      decompressor = described_class.new('(6x1)(1x3)A')
      expect(decompressor.decompressed_text).to eql('(1x3)A')
    end

    it 'survives complicated ones' do
      decompressor = described_class.new('X(8x2)(3x3)ABCY')
      expect(decompressor.decompressed_text).to eql('X(3x3)ABC(3x3)ABCY')
    end
  end

  describe '#decompressed_length' do
    it 'returns the length of the decompressed text' do
      decompressor = described_class.new('ADVENT')
      expect(decompressor.decompressed_length).to eql(6)
    end

    it 'returns the length of an expanded text that is decompressed' do
      decompressor = described_class.new('X(8x2)(3x3)ABCY')
      expect(decompressor.decompressed_length).to eql(18)
    end

    it 'accurately processes lengths longer than 9' do
      decompressor = described_class.new('(1x10)X')
      expect(decompressor.decompressed_length).to eql(10)
    end
  end

  context 'with Advent Code input' do
    it 'solves the puzzle' do
      compressed_text = File.read('./spec/fixtures/decompressor_input.txt')
      decompressor = described_class.new(compressed_text)
      expect(decompressor.decompressed_length).to eql(150914)
    end
  end
end
