class Bot
  attr_reader :name, :chips

  def initialize(name)
    @name = name.to_s
    @chips = []
    @low_chip_target = nil
    @high_chip_target = nil
  end

  def execute(command)
    command_type = /(\w+) \d+/.match(command)[1]
    if command_type == 'value'
      add_chip(/\w+ (\d+)/.match(command)[1].to_i)
    end
    if command_type == 'bot'
      @low_chip_target = /gives low to \w+ (\d+)/.match(command)[1]
      @high_chip_target = /high to \w+ (\d+)/.match(command)[1]
    end
    self
  end

  def add_chip(chip_number)
    if @chips.empty? || @chips.first < chip_number
      @chips.push(chip_number)
    elsif @chips.first > chip_number
      @chips.insert(0, chip_number)
    end
    self
  end

  def pass_chips
    low = @chips.first
    high = @chips.last
    @chips.clear
    return [@low_chip_target, low], [@high_chip_target, high]
  end
end
