class AssignChip
  attr_reader :bot, :chip_number

  def initialize(bot, chip_number)
    @bot = bot
    @chip_number = chip_number
  end

  def execute
    if @bot.add_chip(@chip_number) == "#{@bot.name},pass_chips"
      "#{@bot.name},pass_chips"
    else
      nil
    end
  end

  def undo
    @bot.chips.delete(@chip_number)
  end
end
