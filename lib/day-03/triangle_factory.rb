require_relative 'triangle'

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
