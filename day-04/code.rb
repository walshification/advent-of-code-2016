class Code
  def initialize(code)
    @code = code
    @encrypted_name = nil
    @sector_id = nil
    @checksum = nil
    @five_most_common_letters = nil
  end

  def encrypted_name
    @encrypted_name ||= parse_name
  end

  def sector_id
    @sector_id ||= parse_sector_id
  end

  def checksum
    @check_sum ||= parse_checksum
  end

  def real?
    validate_checksum
  end

  private

  def parse_name
    code_parts = @code.split('-')
    @encrypted_name = code_parts[0, code_parts.length - 1].join
  end

  def parse_sector_id
    @sector_id = /(\d{3})/.match(@code).captures.first.to_i
  end

  def parse_checksum
    @checksum = /\[{1}(\w*)\]{1}/.match(@code).captures.first
  end

  def validate_checksum
    (0..5).all? { |i| five_most_common_letters[i] == checksum[i] }
  end

  def five_most_common_letters
    @five_most_common_letters ||= sort_by_value(encrypted_name.chars)
  end

  def sort_by_value(char_string)
    sorted = {}
    char_string.each { |letter| sorted[letter] = char_string.count(letter) }
    # converts sorted to an array of array pairs from the hash
    new_sorted = sorted.sort_by { |_, count| count }.reverse
    # [["e", 2], ["t", 2], ["d", 1], ["o", 1], ["c", 1], ["s", 1]]
    count_hash = {}
    new_sorted.each do |letter_count_pair|
      unless count_hash[letter_count_pair[1].to_s].nil?
        count_hash[letter_count_pair[1].to_s] << letter_count_pair[0]
      else
        count_hash[letter_count_pair[1].to_s] = []
        count_hash[letter_count_pair[1].to_s] << letter_count_pair[0]
      end
    end
    top_five_letters(count_hash)
  end

  def top_five_letters(count)
    sorted_char_list(count).map { |_, letters| letters }.join[0, 5]
  end

  def sorted_char_list(count)
    count.each { |_, letters| letters.sort! }
  end
end
