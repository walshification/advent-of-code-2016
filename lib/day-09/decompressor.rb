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
      unless important_character?(@text[char_index])
        char_index += 1
        next
      end
      if @text[char_index] == '('
        copy_length, copy_number = parse(compression_marker_at(char_index))
        char_index += copy_length.length + copy_number.length + 3
        decompressed << expanded_text(char_index, copy_length, copy_number)
        char_index += copy_length.to_i
      else
        decompressed << @text[char_index]
        char_index += 1
      end
    end
    decompressed.flatten.join
  end

  def important_character?(current_character)
    current_character =~ /[A-Za-z\(\)0-9]/
  end

  def compression_marker_at(char_index)
    /\(([\d]+x[\d]+)\)/.match(@text.slice(char_index, 10))
  end

  def parse(compression_marker)
    compression_marker.captures.first.split('x')
  end

  def expanded_text(char_index, copy_length, copy_number)
    @text.slice(char_index, copy_length.to_i) * copy_number.to_i
  end
end
