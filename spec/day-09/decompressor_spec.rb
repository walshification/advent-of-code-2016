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
  end

  describe '#decompressed_length' do
    it 'returns the length of the decompressed text' do
      decompressor = described_class.new('ADVENT')
      expect(decompressor.decompressed_length).to eql(6)
    end
  end
end
