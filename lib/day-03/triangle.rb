class Triangle
  def initialize(sides)
    @side_one = sides[0]
    @side_two = sides[1]
    @side_three = sides[2]
  end

  def possible?
    [
      side_one_valid?,
      side_two_valid?,
      side_three_valid?,
    ].all?
  end

  private

  def side_one_valid?
    @side_one < @side_two + @side_three
  end

  def side_two_valid?
    @side_two < @side_one + @side_three
  end

  def side_three_valid?
    @side_three < @side_one + @side_two
  end
end
