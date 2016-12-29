class KeycardScreen
  DEFAULT_SCREEN = Array.new(6, Array.new(50, '.'))

  def initialize(screen=nil)
    @screen = screen || DEFAULT_SCREEN
  end

  def window
    "#{@screen.map { |row| "#{row.join}\n" }.join }"
  end

  def scan_keycard(command)
    keyword, dimensions = command.split(' ')
    if keyword == 'rect'
      x_limit, y_limit = dimensions.split('x')
      y = 0
      while y < y_limit.to_i
        x = 0
        while x < x_limit.to_i
          @screen[y][x] = 'X'
          x += 1
        end
        y += 1
      end
    end
  end
end
