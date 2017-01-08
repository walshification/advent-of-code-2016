class Bot
  attr_reader :name

  def initialize(name)
    @name = name
    @chips = {}
  end

  def chips
    @chips.values.sort
  end

  def add_chip(chip_number)
    @chips[chip_number.to_s] = chip_number
    self
  end

  def pass_chip(chip_number)
    @chips.delete(chip_number.to_s)
  end
end
