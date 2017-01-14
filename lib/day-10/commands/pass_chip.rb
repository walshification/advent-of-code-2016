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
    @low_target_bot.add_chip(low_chip)
    @high_target_bot.add_chip(high_chip)
    if low_chip == 17 and high_chip == 61
      return "#{@origin_bot.name},advent_bot"
    end
  end

  def undo
    @origin_bot.add_chip(@low_target_bot.pass_low_chip)
    @origin_bot.add_chip(@high_target_bot.pass_high_chip)
  end
end
