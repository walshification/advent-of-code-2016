class Decryptor
  def decrypt(code)
    rotate_letters(code)
  end

  private

  def rotate_letters(code)
    code.encrypted_name.chars.map do |char|
      next ' ' if char == '-'
      alphabet[((code.sector_id + alphabet.index(char)) % 26)]
    end.join
  end

  def alphabet
    ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  end
end
