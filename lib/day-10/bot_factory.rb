require_relative 'bot'

class BotFactory
  def initialize
    @bots = {}
  end

  def bots
    @bots.values.sort
  end

  def process(command)
    command_type = /(\w+) \d+/.match(command)[1]
    if command_type == 'value'
      target_bot = /bot (\d+)/.match(command)[1]
      unless @bots[target_bot]
        new_bot = Bot.new(target_bot.to_i)
        @bots[new_bot.name] = new_bot
      end
      @bots[target_bot].add_chip(/\w+ (\d+)/.match(command)[1].to_i)
    end
  end
end
