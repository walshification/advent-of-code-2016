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
    @text
  end
end
