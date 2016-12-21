require 'yaml'

require 'day-02/decoder'

RSpec.describe Decoder do
  let(:decoder) { Decoder.new }

  describe '#decode' do
    context 'with defaults' do
      it 'starts on the center button of a 3x3 keypad' do
        expect(decoder.decode).to eql('5')
      end

      it 'moves up on the keypad when given U' do
        expect(decoder.decode('U')).to eql('2')
      end

      it 'moves down on the keypad with given D' do
        expect(decoder.decode('D')).to eql('8')
      end

      it 'moves right on the keypad with given R' do
        expect(decoder.decode('R')).to eql('6')
      end

      it 'moves left on the keypad with given L' do
        expect(decoder.decode('L')).to eql('4')
      end

      it 'moves according to a string of commands' do
        expect(decoder.decode('UL')).to eql('1')
      end

      it 'stops at the edge of the keypad' do
        expect(decoder.decode('ULL')).to eql('1')
      end

      it 'returns a number for each string of commands given' do
        expect(decoder.decode('ULL', 'D')).to eql('14')
      end
    end

    context 'with optional keypad argument' do
      it 'allows you to change the shape of the keypad' do
        alt_pad = [
          [nil, nil, '1', nil, nil],
          [nil, '2', '3', '4', nil],
          ['5', '6', '7', '8', '9'],
          [nil, 'A', 'B', 'C', nil],
          [nil, nil, 'D', nil, nil],
        ]
        alt_decoder = Decoder.new(alt_pad)
        expect(alt_decoder.decode).to eql('2')
      end
    end

    context 'with optional position argument' do
      it 'allows you to change the starting position on the keypad' do
        repositioned_decoder = Decoder.new(position: [0, 0])
        expect(repositioned_decoder.decode).to eql('1')
      end
    end
  end

  describe 'with Advent Code input' do
    it 'solves the puzzle' do
      advent_input = YAML.load_file('./spec/fixtures/decoder_input.yaml')
        alt_pad = [
        [nil, nil, '1', nil, nil],
        [nil, '2', '3', '4', nil],
        ['5', '6', '7', '8', '9'],
        [nil, 'A', 'B', 'C', nil],
        [nil, nil, 'D', nil, nil],
      ]
      decoder = Decoder.new(alt_pad, position: [2, 0])
      expect(decoder.decode(*advent_input)).to eql('A47DA')
    end
  end
end
