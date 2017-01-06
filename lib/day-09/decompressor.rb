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
      unless @text[char_index] =~ /[A-Za-z\(\)0-9]/
        char_index += 1
        next
      end
      if @text[char_index] == '('
        slice_match = /\(([\d]+x[\d]+)\)/.match(@text.slice(char_index, 10))
        copy_length, copy_number = slice_match.captures.first.split('x')
        char_index += copy_length.length + copy_number.length + 3
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
