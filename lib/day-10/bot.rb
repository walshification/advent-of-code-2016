class Bot
  attr_reader :name, :chips

  def initialize(name)
    @name = name.to_s
    @chips = []
  end

  def pass_low_chip
    @chips.shift
  end

  def pass_high_chip
    @chips.pop
  end

  def add_chip(chip_number)
    @chips.push(chip_number).sort!
    if @chips.length > 1
      return "#{name},pass_chips"
    end
    nil
  end
end
