class TriangleValidator
  attr_reader :triangles

  def initialize(side_length_triples)
    @triangles = side_length_triples.map { |sides| Triangle.new(*sides) }
    @possibles = nil
  end

  def validate
    @possibles ||= @triangles.select { |triangle| triangle.possible? }
  end
end

class Triangle
  attr_reader :side_one, :side_two, :side_three

  def initialize(*sides)
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
