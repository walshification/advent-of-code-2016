class Decompressor
  def initialize(text)
    @text = text
  end

  def decompressed_text
    @decompressed_text ||= decompress
  end

  def decompressed_length
    decompressed_text.length
  end

  private

  def decompress
    decompressed = []
    char_index = 0
    while char_index < @text.length
      if @text[char_index] == '('
        copy_length, copy_number = @text.slice(char_index + 1, 3).split('x')
        char_index += 5
        decompressed << @text.slice(char_index, copy_length.to_i) * copy_number.to_i
        char_index += copy_length.to_i
      else
        decompressed << @text[char_index]
        char_index += 1
      end
    end
    decompressed.flatten.join
  end
end
