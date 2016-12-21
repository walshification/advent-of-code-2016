class TriangleValidator
  attr_reader :possibles

  def initialize(triangles)
    @triangles = triangles
    @possibles = nil
  end

  def validate
    @possibles ||= @triangles.select { |triangle| triangle.possible? }
  end
end
