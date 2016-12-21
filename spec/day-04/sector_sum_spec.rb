require 'yaml'

require 'day-04/sector_sum'
require 'day-04/code'

RSpec.describe SectorSum do
  let(:code_1) { double('code 1') }
  let(:code_2) { double('code 2') }

  before(:each) do
    allow(code_1).to receive(:sector_id) { 100 }
    allow(code_2).to receive(:sector_id) { 101 }
    allow(code_1).to receive(:real?) { true }
  end

  describe '#sum_codes' do
    context 'with valid room codes' do
      it 'sums sector IDs together' do
        allow(code_2).to receive(:real?) { true }

        sector_sum = SectorSum.new([code_1, code_2])
        expect(sector_sum.sum_codes).to eql(201)
      end
    end

    context 'with fake rooms' do
      it 'filters out rooms that are not real when it sums' do
        allow(code_2).to receive(:real?) { false }

        sector_sum = SectorSum.new([code_1, code_2])
        expect(sector_sum.sum_codes).to eql(100)
      end
    end

    it 'remembers the sum so it only calculates it once' do
      allow(code_2).to receive(:real?) { true }

      sector_sum = SectorSum.new([code_1, code_2])
      sector_sum.sum_codes
      sector_sum.sum_codes
      expect(code_1).to have_received(:sector_id).once
    end
  end

  context 'with Advent Code input' do
    it 'solves the puzzle' do
      advent_input = YAML.load_file('./spec/fixtures/sector_sum_input.yaml')
      advent_codes = advent_input.map { |code| Code.new(code) }

      expect(SectorSum.new(advent_codes).sum_codes).to eql(185371)
    end
  end
end
