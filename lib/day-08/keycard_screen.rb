class KeycardScreen
  DEFAULT_SCREEN = [
    Array.new(50, '.'),
    Array.new(50, '.'),
    Array.new(50, '.'),
    Array.new(50, '.'),
    Array.new(50, '.'),
    Array.new(50, '.'),
  ]

  COMMANDS = {
    'rect'   => 'activate',
    'rotate' => 'rotate',
  }

  def initialize(screen=nil)
    @screen = screen || DEFAULT_SCREEN
    @screen_height = @screen.length
    @screen_width = @screen.first.length
  end

  def window
    "#{@screen.map { |row| "#{row.join}\n" }.join }"
  end

  def scan_keycard(commands)
    commands.each { |command| pixelate(command) }
  end

  def pixelate(command)
    command_parts = command.split(' ')
    keyword = command_parts.first
    body = command_parts.slice(1, command_parts.length)
    self.send(COMMANDS[keyword], body)
  end

  def reset
    @screen.each_with_index do |row, i|
      row.each_with_index do |_, j|
        @screen[i][j] = '.'
      end
    end
  end

  private

  def activate(command_body)
    width, height = command_body.first.split('x')
    y = 0
    while y < height.to_i
      x = 0
      while x < width.to_i
        @screen[y][x] = '#'
        x += 1
      end
      y += 1
    end
  end

  def rotate(command_body)
    _, dimension, _, limit = command_body
    axis, degree = dimension.split('=')

    if axis == 'x'
      @screen.map { |rows| rows[degree.to_i] }.each_with_index do |dimension_value, i|
        @screen[(i + limit.to_i) % @screen_height][degree.to_i] = dimension_value
      end
    elsif axis == 'y'
      y = degree.to_i
      @screen[y].map { |dimension_value| dimension_value }.each_with_index do |dimension_value, i|
        @screen[y][(i + limit.to_i) % @screen_width] = dimension_value
      end
    end
  end
end
