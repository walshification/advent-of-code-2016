require 'day-10/bot'

RSpec.describe Bot do
  describe '#initialize' do
    it 'assigns itself a given name' do
      expect(Bot.new('Charlie').name).to eql('Charlie')
    end

    it 'converts the name to a string if it needs to' do
      expect(Bot.new(42).name).to eql('42')
    end
  end

  describe '#add_chip' do
    it 'accepts a chip with a number to process' do
      bot = Bot.new('bot')
      bot.add_chip(53)
      expect(bot.chips).to eql([53])
    end

    it 'returns a pass_chips event when bot has two chips' do
      bot = Bot.new('bot')
      bot.add_chip(53)
      event = bot.add_chip(42)
      expect(event).to eql('bot,pass_chips')
    end
  end
end
