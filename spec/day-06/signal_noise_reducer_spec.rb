require 'spec_helper'
require 'yaml'

require 'day-06/signal_noise_reducer'

RSpec.describe SignalNoiseReducer do
  describe '#run' do
    it 'returns the most common characters in a column as a string' do
      test_message = [
        'abd',
        'aec',
        'abe',
        'brc',
      ]
      reducer = SignalNoiseReducer.new(test_message)
      expect(reducer.run).to eql('abc')
    end

    it 'passes the advent sanity test' do
      test_message = [
        'eedadn',
        'drvtee',
        'eandsr',
        'raavrd',
        'atevrs',
        'tsrnev',
        'sdttsa',
        'rasrtv',
        'nssdts',
        'ntnada',
        'svetve',
        'tesnvt',
        'vntsnd',
        'vrdear',
        'dvrsen',
        'enarar',
      ]
      reducer = SignalNoiseReducer.new(test_message)
      expect(reducer.run).to eql('easter')
    end

    context 'with Advent Code input' do
      it 'solves the puzzle' do
        advent_input = YAML.load_file('./spec/fixtures/signal_input.yaml')
        reducer = SignalNoiseReducer.new(advent_input)
        expect(reducer.run).to eql('tzstqsua')
      end

      it 'solves the puzzle for min values too' do
        advent_input = YAML.load_file('./spec/fixtures/signal_input.yaml')
        reducer = SignalNoiseReducer.new(advent_input, 'min')
        expect(reducer.run).to eql('myregdnr')
      end
    end
  end
end
