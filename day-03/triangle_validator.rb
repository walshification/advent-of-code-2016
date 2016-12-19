class TriangleValidator
  attr_reader :triangles

  def initialize(triangles)
    @triangles = triangles
    @possibles = nil
  end

  def validate
    @possibles ||= @triangles.select { |triangle| triangle.possible? }
  end
end

class Triangle
  attr_reader :side_one, :side_two, :side_three

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

class TriangleFactory
  def self.for(triangle_type, side_length_triples)
    if triangle_type == :standard
      side_length_triples.map { |sides| Triangle.new(sides) }
    elsif triangle_type == :transposed
      side_matrices = []
      while side_length_triples.any?
        side_matrices += side_length_triples.slice!(0, 3).transpose
      end
      side_matrices.map { |sides| Triangle.new(sides) }
    else
      raise "Can't make triangles out of unidentified type."
    end
  end
end
