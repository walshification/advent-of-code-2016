class Ip
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def supports_tls?
    return false if hypernet_abbas.any?
    silus_abbas.any?
  end

  private

  def hypernet_abbas
    @hypernet_abbas ||= hypernet_sequence.map do |seq|
      parse_groups(seq).map { |group| abba_parse(group) }
    end.flatten
  end

  def silus_abbas
    @silus_abbas = silus.map do |sequence|
      parse_groups(sequence).map { |group| abba_parse(group) }
    end.flatten
  end

  def hypernet_abas
    @hypernet_abas ||= hypernet_sequence.map do |seq|
      parse_groups(seq).map { |group| ada_parse(group) }
    end.flatten
  end

  def hypernet_sequence
    @address.scan(/\[([\w]+)\]/).flatten
  end

  def silus
    @silus ||= @address.scan(/[\[]?(\w+)[\]]?/).flatten
  end

  def parse_groups(sequence)
    i = 0
    abba_groups = []
    while i + 4 <= sequence.length
      abba_groups << sequence.slice(i, 4)
      i += 1
    end
    abba_groups
  end

  def abba_parse(clump)
    (clump[0] == clump[3] &&
     clump[1] == clump[2] &&
     clump[0] != clump[1])
  end
end
