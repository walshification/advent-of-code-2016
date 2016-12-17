class Gps
  def initialize(bearing=0)
    @bearing = bearing
    @x = 0
    @y = 0
    @history = [[0, 0]]
  end

  def bearing
    @bearing
  end

  def coordinates
    return @x, @y
  end

  def advance(command='A1')
    steps = command.split(', ')
    steps.each do |step|
      orientation, speed = parse(step)

      orient(orientation)
      speed.times do
        move(1)
        return if visited?
        record_spot
      end
    end
  end

  def blocks_away
    @x.abs + @y.abs
  end

  private

  def parse(step)
    return step[0], step.slice(1, (step.length - 1)).to_i
  end

  def orient(orientation)
    if orientation == 'L'
      turn_left
    elsif orientation == 'R'
      turn_right
    end
  end

  def turn_left
    @bearing = (@bearing - 1) % 4
  end

  def turn_right
    @bearing = (@bearing + 1) % 4
  end

  def move(speed)
    if @bearing == 0
      @y += speed
    elsif @bearing == 1
      @x += speed
    elsif @bearing == 2
      @y -= speed
    else
      @x -= speed
    end
  end

  def visited?
    @history.include?(coordinates)
  end

  def record_spot
    @history << coordinates
  end
end
