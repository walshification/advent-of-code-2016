require 'yaml'

require 'day-01/gps'

RSpec.describe Gps, type: :model do
  let(:gps) { described_class.new }

  describe '#initialize' do
    it 'sets intial starting coordinates to [0, 0]' do
      expect(gps.coordinates).to eql([0, 0])
    end
  end

  describe '#advance' do
    it 'defaults to moving forward by one step' do
      gps.advance
      expect(gps.coordinates).to eql([0, 1])
    end

    it 'moves forward a number of steps given' do
      gps.advance('A2')
      expect(gps.coordinates).to eql([0, 2])
    end

    it 'turns left if told L' do
      gps.advance('L1')
      expect(gps.coordinates).to eql([-1, 0])
    end

    it 'turns right if told R' do
      gps.advance('R1')
      expect(gps.coordinates).to eql([1, 0])
    end

    it 'can move according to a string of commands' do
      gps.advance('L1, L4, R2')
      expect(gps.coordinates).to eql([-3, -4])
    end

    it 'understands 3-digit speeds' do
      gps.advance('A188')
      expect(gps.coordinates).to eql([0, 188])
    end

    it 'stops if it reaches a point already visited' do
      gps.advance('R8, R4, R4, R8')
      expect(gps.coordinates).to eql([4, 0])
    end
  end

  describe '#blocks_away' do
    it 'returns how many blocks away it is from the start' do
      gps.advance('A4')
      expect(gps.blocks_away).to eql(4)
    end

    it 'returns how many blocks away after a string of commands' do
      gps.advance('L1, L4, R1')
      expect(gps.blocks_away).to eql(6)
    end

    it 'can calculate steps across corners' do
      gps.advance('L4, L1, R4, R1, R1, L3, R5')
      expect(gps.coordinates).to eql([-2, 3])
      expect(gps.blocks_away).to eql(5)
    end
  end

  describe 'with Advent Code input' do
    it 'solves the puzzle' do
      input = YAML.load_file('./spec/fixtures/gps_input.yaml')
      gps.advance(input)
      expect(gps.blocks_away).to eql(163)
    end
  end
end
