class Decoder
  KEYPAD = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
  ]

  def initialize(keypad=KEYPAD, position: nil)
    @position = position || [1, 1]
    @keypad = keypad
  end

  def decode(*codes)
    return @keypad[@position[0]][@position[1]] unless codes.any?
    code_to_action = {
      'U' => 'move_up',
      'D' => 'move_down',
      'R' => 'move_right',
      'L' => 'move_left',
    }
    codes.map do |code_string|
      code_string.chars.each do |code_char|
        self.send(code_to_action[code_char])
      end
      @keypad[@position[0]][@position[1]]
    end.join
  end

  private

  def move_up
    return if upper_edge?(@position[0])
    @position[0] -= 1
  end

  def move_down
    return if lower_edge?(@position[0])
    @position[0] += 1
  end

  def move_right
    return if right_edge?(@position[1])
    @position[1] += 1
  end

  def move_left
    return if left_edge?(@position[1])
    @position[1] -= 1
  end

  def upper_edge?(position)
    position == 0 || @keypad[position - 1][@position[1]].nil?
  end

  def lower_edge?(position)
    position == @keypad.length - 1 || @keypad[position + 1][@position[1]].nil?
  end

  def right_edge?(position)
    position == @keypad[0].length - 1 || @keypad[@position[0]][position + 1].nil?
  end

  def left_edge?(position)
    position == 0 || @keypad[@position[0]][position - 1].nil?
  end
end
