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
      bot = Bot.new('bot').add_chip(53)
      expect(bot.chips).to eql([53])
    end

    it 'sorts chips as it adds them' do
      bot = Bot.new('bot').add_chip(53).add_chip(42)
      expect(bot.chips).to eql([42, 53])
    end
  end

  describe '#pass_chips' do
    it 'removes a chip from its list and returns it for another bot' do
      bot = Bot.new('bot').add_chip(53).add_chip(42)
      expect(bot.pass_chips).to eql([[nil, 42], [nil, 53]])
      expect(bot.chips).to eql([])
    end
  end

  describe '#execute' do
    context 'give command' do
      it 'pairs the low and high chips with respective bot targets' do
        bot = Bot.new('bot')
                 .execute('bot 2 gives low to bot 1 and high to bot 0')
                 .add_chip(53)
                 .add_chip(42)
        expect(bot.pass_chips).to eql([['1', 42], ['0', 53]])
        expect(bot.chips).to eql([])
      end
    end
  end
end
