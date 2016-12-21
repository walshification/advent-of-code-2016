require 'day-03/triangle_factory'

RSpec.describe TriangleFactory do
  describe '.for' do
    context ':standard triangles' do
      it 'creates an array of triangles from their array of sides' do
        triangle = TriangleFactory.for(:standard, [[3, 4, 5]]).first
        expect(triangle.class).to eql(Triangle)
      end

      it 'creates more than one triangle if given multiple dimensions' do
        triangles = TriangleFactory.for(:standard, [[3, 4, 5], [2, 2, 1]])
        expect(triangles.count).to eql(2)
      end
    end

    context ':transposed triangles' do
      it 'creates an array of triangles by transposing row and column dimensions' do
        triangles = TriangleFactory.for(
          :transposed,
          [[3, 4, 5], [2, 2, 1], [3, 4, 5]]
        )
        expect(triangles.count).to eql(3)
      end
    end

    context 'invalid triangle type' do
      it 'raises an error' do
        expect { TriangleFactory.for(:nonsense, [[3, 4, 5]]) }.to raise_error(RuntimeError)
      end
    end
  end
end
