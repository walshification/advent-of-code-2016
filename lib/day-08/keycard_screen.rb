class KeycardScreen
  DEFAULT_SCREEN = [
    Array.new(50, '.'),
    Array.new(50, '.'),
    Array.new(50, '.'),
    Array.new(50, '.'),
    Array.new(50, '.'),
    Array.new(50, '.'),
  ]

  def initialize(screen=nil)
    @screen = screen || DEFAULT_SCREEN
    @screen_height = @screen.length
    @screen_width = @screen.first.length
  end

  def window
    "#{@screen.map { |row| "#{row.join}\n" }.join }"
  end

  def scan_keycard(commands)
    if commands.class == Array
      commands.each { |command| pixelate(command) }
    else
      pixelate(commands)
    end
  end

  def pixelate(command)
    command_parts = command.split(' ')
    if command_parts.first == 'rect'
      x_limit, y_limit = command_parts[1].split('x')
      y = 0
      while y < y_limit.to_i
        x = 0
        while x < x_limit.to_i
          @screen[y][x] = '#'
          x += 1
        end
        y += 1
      end
    end
    if command_parts.first == 'rotate'
      _, _, column, _, limit = command_parts
      dimension, value = column.split('=')
      if dimension == 'x'
        current_values = @screen.map { |rows| rows[value.to_i] }
        current_values.each_with_index do |y_value, i|
          @screen[(i + limit.to_i) % @screen_height][value.to_i] = y_value
        end
      end
      if dimension == 'y'
        y = value.to_i
        current_values = @screen[y].map { |x_value| x_value }
        current_values.each_with_index do |x_value, i|
          @screen[y][(i + limit.to_i) % @screen_width] = x_value
        end
      end
    end
    window
  end
end
