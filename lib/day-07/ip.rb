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
      parse_groups(4, seq).map { |group| abba?(group) }
    end.flatten
  end

  def silus_abbas
    @silus_abbas = silus.map do |sequence|
      parse_groups(4, sequence).map { |group| abba?(group) }
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

  def abba?(sequence)
    template = {
      matching_pairs: [
        [sequence[0], sequence[3]],
        [sequence[1], sequence[2]],
      ],
      different_pairs: [
        [sequence[0], sequence[1]],
      ]
    }
    valid_sequence?(template)
  end

  def aba?(sequence)
    template = {
      matching_pairs: [
        [sequence[0], sequence[2]]
      ],
      different_pairs: [
        [sequence[0], sequence[1]]
      ],
    }
    valid_sequence?(template)
  end

  def valid_sequence?(template)
    template.keys.map do |group|
      if group == :matching_pairs
        template[group].map do |pairs|
          _match?(*pairs)
        end
      elsif group == :different_pairs
        template[group].map do |pairs|
          different?(*pairs)
        end
      end
    end.flatten.all?
  end

  def compliment?(sequence_1, sequence_2)
    (_match?(sequence_2[0], sequence_2[2]) &&
     _match?(sequence_1[0], sequence_2[1]) &&
     _match?(sequence_1[1], sequence_2[0]))
  end

  def _match?(char_1, char_2)
    char_1 == char_2
  end

  def different?(char_1, char_2)
    char_1 != char_2
  end
end
