require 'day-10/commands'

RSpec.describe PassChip do
  let(:origin_bot) { build(:bot) }
  let(:low_target_bot) { build(:bot, name: 'bot 5') }
  let(:high_target_bot) { build(:bot, name: 'bot 6') }

  before(:each) do
    origin_bot.add_chip(1)
    origin_bot.add_chip(2)
  end

  describe '#execute' do
    it 'removes chips from one bot and adds to others' do
      expect(low_target_bot.chips).to eql([])
      expect(high_target_bot.chips).to eql([])
      expect(origin_bot.chips).to eql([1, 2])

      described_class.new(origin_bot, low_target_bot, high_target_bot).execute

      expect(low_target_bot.chips).to eql([1])
      expect(high_target_bot.chips).to eql([2])
      expect(origin_bot.chips).to eql([])
    end

    it 'returns an advent_bot event when a bot compares the magic chips' do
      advent_bot = build(:bot, name: 'advent')
      advent_bot.add_chip(17)
      advent_bot.add_chip(61)
      pass = described_class.new(advent_bot, low_target_bot, high_target_bot)
      expect(pass.execute).to eql('advent,advent_bot')
    end
  end

  describe '#undo' do
    it 'returns bots to state prior to command execution' do
      command = described_class.new(origin_bot, low_target_bot, high_target_bot)

      expect(low_target_bot.chips).to eql([])
      expect(high_target_bot.chips).to eql([])
      expect(origin_bot.chips).to eql([1, 2])

      command.execute

      expect(low_target_bot.chips).to eql([1])
      expect(high_target_bot.chips).to eql([2])
      expect(origin_bot.chips).to eql([])

      command.undo

      expect(low_target_bot.chips).to eql([])
      expect(high_target_bot.chips).to eql([])
      expect(origin_bot.chips).to eql([1, 2])
    end
  end
end
