require 'day-10/bot'

RSpec.describe Bot do
  describe '#initialize' do
    it 'assigns itself a given name' do
      expect(Bot.new('Charlie').name).to eql('Charlie')
    end
  end

  describe '#add_chip' do
    it 'accepts a chip with a number to process' do
      bot = Bot.new('bot').add_chip(53)
      expect(bot.chips).to eql([53])
    end
  end

  describe '#pass_chip' do
    it 'removes a chip from its list and returns it for another bot' do
      bot = Bot.new('bot').add_chip(53)
      expect(bot.pass_chip(53)).to eql(53)
      expect(bot.chips).to eql([])
    end
  end
end
