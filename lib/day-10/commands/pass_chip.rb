class PassChip
  attr_reader :origin_bot

  def initialize(origin_bot, low_target_bot, high_target_bot)
    @origin_bot = origin_bot
    @low_target_bot = low_target_bot
    @high_target_bot = high_target_bot
  end

  def execute
    low_chip = @origin_bot.pass_low_chip
    high_chip = @origin_bot.pass_high_chip
    low_event = @low_target_bot.add_chip(low_chip)
    high_event = @high_target_bot.add_chip(high_chip)
    check_events(low_chip, high_chip, low_event, high_event)
  end

  def undo
    @origin_bot.add_chip(@low_target_bot.pass_low_chip)
    @origin_bot.add_chip(@high_target_bot.pass_high_chip)
  end

  private

  def check_events(low_chip, high_chip, low_event, high_event)
    if low_chip == 17 && high_chip == 61
      return "#{@origin_bot.name},advent_bot"
    elsif low_event && high_event
      return "#{low_event};#{high_event}"
    elsif low_event
      return low_event
    elsif high_event
      return high_event
    end
  end
end
