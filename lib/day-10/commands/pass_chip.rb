class PassChip
  attr_reader :origin_bot

  def initialize(origin_bot, low_target_bot, high_target_bot)
    @origin_bot = origin_bot
    @low_target_bot = low_target_bot
    @high_target_bot = high_target_bot
  end

  def execute
    events = []
    events << "#{@origin_bot.name},advent_bot" if advent_bot?
    events += [
      @low_target_bot.add_chip(@origin_bot.pass_low_chip),
      @high_target_bot.add_chip(@origin_bot.pass_high_chip),
    ].compact
    events.any? ? events.join(';') : nil
  end

  def undo
    @origin_bot.add_chip(@low_target_bot.pass_low_chip)
    @origin_bot.add_chip(@high_target_bot.pass_high_chip)
  end

  private

  def advent_bot?
    @origin_bot.chips.first == 17 && @origin_bot.chips.last == 61
  end
end
