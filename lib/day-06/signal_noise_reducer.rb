class SignalNoiseReducer
  def initialize(messages, filter_value='max')
    @messages = messages
    @filter_value = filter_value
  end

  def run
    @message ||= transposed_messages.map do |char_list|
      most_common(char_list)
    end.join
  end

  private

  def transposed_messages
    @transposed_messages ||= @messages.map { |message| message.split('') }
                                      .transpose
  end

  def most_common(character_list)
    char_count = character_list.inject(Hash.new(0)) { |h, char| h[char] += 1; h }
    character_list.send("#{@filter_value}_by") { |char| char_count[char] }
  end
end
