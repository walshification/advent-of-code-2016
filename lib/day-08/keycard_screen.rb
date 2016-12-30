class KeycardScreen
  DEFAULT_SCREEN = Array.new(6, Array.new(50, '.'))

  def initialize(screen=nil)
    @screen = screen || DEFAULT_SCREEN
    @screen_height = @screen.length
    @screen_width = @screen.first.length
  end

  def window
    "#{@screen.map { |row| "#{row.join}\n" }.join }"
  end

  def scan_keycard(command)
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
      keyword, axis, column, _, limit = command_parts
      dimension, value = column.split('=')
      if dimension == 'x'
        y = 0
        new_value = nil
        while y < @screen_height
          new_value ||= @screen[(y - limit.to_i) % @screen_height][value.to_i]
          current_value = @screen[y][value.to_i]
          @screen[y][value.to_i] = new_value
          new_value = current_value
          y += 1
        end
      end
    end
    window
  end
end
