require_relative 'bot'
require_relative 'commands'

class BotFactory
  def initialize(commands)
    options ||= {}
    @bots = {}
    @commands = setup(commands)
    @state_events = []
    @history = []
  end

  def bots
    @bots.values.sort
  end

  def orchestrate
    @commands.each do |initial_command|
      @state_events << initial_command
      while @state_events.any?
        command = @state_events.pop
        event = command.execute
        @history << command
        unless event.nil?
          event_bot, event_command = event.split(',')
          @state_events.unshift(event_command_for(@bots[event_bot]))
        end
      end
    end
  end

  private

  def setup(commands)
    commands.map do |command|
      command_type = /(\w+) \d+/.match(command)[1]
      if command_type == 'value'
        AssignChip.new(create_or_find_bot(/(bot \d+)/.match(command)[1]),
                       /\w+ (\d+)/.match(command)[1].to_i)
      elsif command_type == 'bot'
        PassChip.new(create_or_find_bot(/(bot \d+)/.match(command)[1]),
                     create_or_find_bot(/gives low to (bot \d+|output \d+)/.match(command)[1]),
                     create_or_find_bot(/high to (bot \d+|output \d+)/.match(command)[1]))
      end
    end
  end

  def create_or_find_bot(bot_number)
    unless @bots[bot_number]
      @bots[bot_number.to_s] = Bot.new(bot_number.to_s)
    end
    @bots[bot_number]
  end

  def event_command_for(bot)
    event_command = @commands.select do |command|
      command.class == PassChip && command.origin_bot == bot
    end.first
    @commands.delete(event_command)
  end
end
