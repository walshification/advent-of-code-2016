class Ip
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def supports_tls?
    return false if hypernet_abbas.any?
    silus_abbas.any?
  end

  def supports_ssl?
    valid_abas = silus_abas.select { |seq| aba?(seq) }
    valid_babs = hypernet_babs.select { |seq| aba?(seq) }
    valid_abas.map do |aba|
      valid_babs.map do |bab|
        compliment?(aba, bab)
      end
    end.flatten.any?
  end

  private

  def hypernet_abbas
    @hypernet_abbas ||= hypernet_sequence.map do |seq|
      parse_groups(4, seq).map { |group| abba_parse(group) }
    end.flatten
  end

  def silus_abbas
    @silus_abbas = silus.map do |sequence|
      parse_groups(4, sequence).map { |group| abba_parse(group) }
    end.flatten
  end

  def hypernet_babs
    @hypernet_babs ||= hypernet_sequence.map do |seq|
      parse_groups(3, seq)
    end.flatten
  end

  def silus_abas
    @silus_abas ||= silus.map do |sequence|
      parse_groups(3, sequence)
    end.flatten
  end

  def hypernet_sequence
    @hypernet_sequence = @address.scan(/\[(\w+)\]/).flatten.select { |w| w }
  end

  def silus
    @silus ||= @address.scan(/(\w+)\[|\](\w+)/).flatten.select { |w| w }
  end

  def parse_groups(length, sequence)
    i = 0
    abba_groups = []
    while i + length <= sequence.length
      abba_groups << sequence.slice(i, length)
      i += 1
    end
    abba_groups
  end

  def abba_parse(clump)
    clump[0] == clump[3] && clump[1] == clump[2] && clump[0] != clump[1]
  end

  def aba?(sequence)
    sequence[0] == sequence[2] && sequence[0] != sequence[1]
  end

  def compliment?(aba, bab)
    bab[0] == bab[2] && aba[0] == bab[1] && aba[1] == bab[0]
  end
end
