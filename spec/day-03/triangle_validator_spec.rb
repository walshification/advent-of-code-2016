require 'yaml'

require 'day-03/triangle_validator'
require 'day-03/triangle_factory'

# print YAML.load_file('./spec/fixtures/triangle_validator_input.yaml')

RSpec.describe TriangleValidator do
  describe '#validate' do
    context 'with possible triangles' do
      it 'returns an array of the triangles' do
        triangle1 = double("fake triangle")
        triangle2 = double("second fake")
        allow(triangle1).to receive(:possible?) { true }
        allow(triangle2).to receive(:possible?) { true }

        validator = TriangleValidator.new([triangle1, triangle2])
        validator.validate
        expect(validator.possibles).to eql([triangle1, triangle2])
      end
    end

    context 'with impossible triangles' do
      it 'filters out the impossible triangles' do
        triangle1 = double("fake triangle")
        triangle2 = double("second fake")
        allow(triangle1).to receive(:possible?) { false }
        allow(triangle2).to receive(:possible?) { false }

        validator = TriangleValidator.new([triangle1, triangle2])
        validator.validate
        expect(validator.possibles).to eql([])
      end
    end

    context 'with Advent Code input' do
      it 'solves the puzzle' do
        dimensions = YAML.load_file('./spec/fixtures/triangle_validator_input.yaml')
        triangles = TriangleFactory.for(:transposed, dimensions)
        validator = TriangleValidator.new(triangles)
        valid_triangles = validator.validate

        expect(valid_triangles.count).to eql(1849)
      end
    end
  end
end

#   def test_solves_the_puzzle
#     triangles = TriangleFactory.for(:transposed, ADVENT_INPUT)
#     validator = TriangleValidator.new(triangles)
#     valid_triangles = validator.validate

#     assert_equal(1849, valid_triangles.count)
#   end
# end
