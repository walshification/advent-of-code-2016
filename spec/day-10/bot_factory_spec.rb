require 'day-10/bot_factory'

RSpec.describe BotFactory do
  describe '#process' do
    it 'creates a bot if it receives a command for a nonexistent bot' do
      fake_bot = double('bot')
      allow(fake_bot).to receive(:name) { '2' }
      allow(fake_bot).to receive(:add_chip)
      allow(Bot).to receive(:new) { fake_bot }

      factory = BotFactory.new
      factory.process('value 5 goes to bot 2')

      expect(factory.bots).to eql([fake_bot])
    end

    it 'adds a chip of appropriate value to the specified bot' do
      fake_bot = double('bot')
      allow(fake_bot).to receive(:name) { '2' }
      allow(Bot).to receive(:new) { fake_bot }

      expect(fake_bot).to receive(:add_chip).with(5)

      factory = BotFactory.new
      factory.process('value 5 goes to bot 2')
    end
  end
end
