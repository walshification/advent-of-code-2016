require 'day-10/bot_factory'

RSpec.describe BotFactory do
  describe '#initialize' do
    it 'creates a bot if it receives a command for a nonexistent bot' do
      bot = build(:bot)
      allow(Bot).to receive(:new) { bot }

      factory = BotFactory.new(['value 5 goes to bot 4'])
      expect(factory.bots).to eql([bot])
    end

    it 'reuses a previously created bot if more than one command applies to it' do
      bot = build(:bot)

      expect(Bot).to receive(:new).once { bot }
      BotFactory.new(['value 5 goes to bot 4', 'value 7 goes to bot 4'])
    end

    it 'creates AssignChip commands for value strings' do
      bot = build(:bot)
      allow(Bot).to receive(:new) { bot }

      expect(AssignChip).to receive(:new).with(bot, 5)
      BotFactory.new(['value 5 goes to bot 4'])
    end

    it 'creates PassChip commands for bot commands' do
      origin_bot = build(:bot)
      low_bot = build(:bot, name: 'bot 5')
      high_bot = build(:bot, name: 'bot 6')
      allow(Bot).to receive(:new).and_return(origin_bot, low_bot, high_bot)

      expect(PassChip).to receive(:new).with(origin_bot, low_bot, high_bot)
      BotFactory.new(['bot 4 gives low to bot 5 and high to bot 6'])
    end
  end

  describe '#orchestrate' do
    it 'executes commands in the order they are listed' do
      bot = build(:bot)
      assign_5 = AssignChip.new(bot, 5)
      assign_6 = AssignChip.new(bot, 6)
      allow(Bot).to receive(:new) { bot }
      allow(AssignChip).to receive(:new).and_return(assign_5, assign_6)

      factory = BotFactory.new([
        'value 5 goes to bot 4',
        'value 6 goes to bot 4',
      ])

      expect(assign_5).to receive(:execute).ordered
      expect(assign_6).to receive(:execute).ordered
      factory.orchestrate
    end

    it 'handles events created by commands' do
      bot = build(:bot)
      low_bot = build(:bot, name: 'bot 5')
      high_bot = build(:bot, name: 'bot 6')
      allow(Bot).to receive(:new).and_return(bot, low_bot, high_bot)
      pass_chip = PassChip.new(bot, low_bot, high_bot)
      allow(PassChip).to receive(:new) { pass_chip }

      factory = BotFactory.new([
        'value 5 goes to bot 4',
        'bot 4 gives low to bot 5 and high to bot 6',
        'value 6 goes to bot 4',
      ])

      expect(pass_chip).to receive(:execute)
      factory.orchestrate
    end

    it 'returns the name of the advent_bot' do
      factory = BotFactory.new([
        'value 17 goes to bot 4',
        'bot 4 gives low to bot 5 and high to bot 6',
        'value 61 goes to bot 4',
      ])

      expect(factory.orchestrate).to eql('bot 4')
    end
  end

  context 'with Advent Code input' do
    it 'solves the puzzle' do
    end
  end
end
