require 'day-10/commands'

RSpec.describe AssignChip do
  let(:bot) { build(:bot) }
  describe '#execute' do
    it 'adds a chip of appropriate value to the specified bot' do
      described_class.new(bot, 42).execute
      expect(bot.chips).to eql([42])
    end

    it 'returns a pass_chips event if chip count is 2 or more' do
      described_class.new(bot, 42).execute
      event = described_class.new(bot, 43).execute
      expect(event).to eql('bot 4,pass_chips')
    end
  end

  describe '#undo' do
    it 'returns bot to prior state' do
      command = described_class.new(bot, 42)

      expect(bot.chips).to eql([])
      command.execute
      expect(bot.chips).to eql([42])
      command.undo
      expect(bot.chips).to eql([])
    end
  end
end
