require_relative 'decompressor'

class UltraDecompressor < Decompressor
  def decompressed_length
    @decompressed_length ||= decompress_for_length(@text)
  end

  private

  def decompress_for_length(text)
    decompressed = 0
    char_index = 0
    while char_index < text.length
      if text[char_index] == '('
        marker = /\(([\d]+x[\d]+)\)/.match(text.slice(char_index, 10))
        copy_length, copy_number = parse(marker).map(&:to_i)
        char_index += copy_length.to_s.length + copy_number.to_s.length + 3
        decompressed += decompress_for_length(text.slice(char_index, copy_length)) * copy_number
        char_index += copy_length
      else
        decompressed += 1
        char_index += 1
      end
    end
    decompressed
  end
end
