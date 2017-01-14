require_relative 'bot'
require_relative 'commands'

class BotFactory
  def initialize(commands)
    @bots = {}
    @commands = []
    @state_events = []
    @pass_events = []
    @history = []
    setup(commands)
  end

  def bots
    @bots.values
  end

  def orchestrate
    @commands.each do |initial_command|
      @state_events << initial_command
      while @state_events.any?
        command = @state_events.pop
        event = command.execute
        @history << command
        unless event.nil?
          event_details = event.split(';')
          event_details.each do |event_detail|
            event_bot, event_type = event_detail.split(',')
            if event_type == 'advent_bot'
              return event_bot
            end
            event_command = event_command_for(@bots[event_bot])
            @state_events << event_command
          end
        end
      end
    end
  end

  def multiply_bins
    @commands.each do |initial_command|
      @state_events << initial_command
      while @state_events.any?
        command = @state_events.pop
        event = command.execute
        @history << command
        unless event.nil?
          event_details = event.split(';')
          event_details.each do |event_detail|
            event_bot, event_type = event_detail.split(',')
            event_command = event_command_for(@bots[event_bot])
            @state_events << event_command
          end
        end
      end
    end
    output_chips.inject(:*)
  end

  private

  def setup(commands)
    commands.each do |command|
      command_type = /(\w+) \d+/.match(command)[1]
      if command_type == 'value'
        bot = create_or_find_bot(/(output \d+|bot \d+)/.match(command)[1])
        chip = /value (\d+)/.match(command)[1].to_i
        @commands << AssignChip.new(bot, chip)
      elsif command_type == 'bot'
        origin_bot = create_or_find_bot(/(bot \d+)/.match(command)[1])
        low_bot = create_or_find_bot(/low to (bot \d+|output \d+)/.match(command)[1])
        high_bot = create_or_find_bot(/high to (bot \d+|output \d+)/.match(command)[1])
        @pass_events << PassChip.new(origin_bot, low_bot, high_bot)
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
    @pass_events.select do |command|
      command.class == PassChip && command.origin_bot == bot
    end.first
  end

  def output_chips
    bots.select { |bot| ['output 0', 'output 1', 'output 2'].include?(bot.name) }
        .map { |bin| bin.chips }.flatten.compact
  end
end
