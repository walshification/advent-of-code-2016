require 'yaml'

require 'day-04/code'
require 'day-04/decryptor'

RSpec.describe Decryptor do
  let(:code) { double('fake code') }
  let(:decryptor) { Decryptor.new }

  before(:each) do
    allow(code).to receive(:encrypted_name) { 'test-code' }
    allow(code).to receive(:sector_id) { 1 }
  end

  describe '#decrypt' do
    it 'replaces dashes with spaces' do
      expect(decryptor.decrypt(code).include?('-')).to eql(false)
    end

    it 'rotates the letters the number of times of the sector ID' do
      expect(decryptor.decrypt(code)).to eql('uftu dpef')
    end

    it 'cycles back to the beginning of the alphabet past z' do
      allow(code).to receive(:sector_id) { 25 }
      expect(decryptor.decrypt(code)).to eql('sdrs bncd')
    end

    it 'can decrypt complicated codes' do
      allow(code).to receive(:encrypted_name) { 'qzmt-zixmtkozy-ivhz' }
      allow(code).to receive(:sector_id) { 343 }
      expect(decryptor.decrypt(code)).to eql('very encrypted name')
    end
  end

  context 'with Advent Code input' do
    it 'solves the puzzle' do
      advent_input = YAML.load_file('./spec/fixtures/sector_sum_input.yaml')
      advent_codes = advent_input.map { |code| Code.new(code) }

      north_pole_room = advent_codes.map do |code|
        if code.real?
          if decryptor.decrypt(code) == 'northpole object storage'
            break code
          end
        end
      end
      expect(north_pole_room.sector_id).to eql(984)
    end
  end
end
