require 'day-04/code'

RSpec.describe Code do
  describe '#encripted_name' do
    it 'parses a code string for the encrypted name' do
      code = Code.new('test-code-123[besty]')
      expect(code.encrypted_name).to eql('test-code')
    end
  end

  describe '#sector_id' do
    it 'parses a code string for the sector ID' do
      code = Code.new('test-code-123[besty]')
      expect(code.sector_id).to eql(123)
    end
  end

  describe '#checksum' do
    it 'parses a code string for the checksum' do
      code = Code.new('test-code-123[besty]')
      expect(code.checksum).to eql('besty')
    end
  end

  describe '#real?' do
    context 'with a valid checksum' do
      it 'identifies a code with a valid checksum' do
        code = Code.new('test-code-123[etcdo]')
        expect(code.real?).to be true
      end
    end

    context 'with an invalid checksum' do
      it 'returns false for a code with an invalid checksum' do
        code = Code.new('test-code-123[besty]')
        expect(code.real?).to be false
      end
    end
  end
end
