require 'day-10/commands'

RSpec.describe AssignChip do
  describe '#execute' do
    it 'adds a chip of appropriate value to the specified bot' do
      bot = build(:bot)

      described_class.new(bot, 42).execute
      expect(bot.chips).to eql([42])
    end
  end
end
