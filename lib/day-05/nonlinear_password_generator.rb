class NonlinearPasswordGenerator
  def initialize(code, options=nil)
    options ||= {}
    @code = code
    @iteration = 0
    @ssl_library = options.fetch(:ssl_library, OpenSSL::Digest)
    @ssl_protocol = options.fetch(:ssl_protocol, 'MD5')
    @password_length = options.fetch(:password_length, 8)
    @hex_key = options.fetch(:hex_key, '00000')
    @hex_representation = ''
    @password = Array.new(@password_length)
  end

  def generate
    while @password.include?(nil)
      position, value = hash_code
      @password[position] = value
    end
    @password.join
  end

  private

  def hash_code
    until valid_hex_code?
      @hex_representation = md5_hash.hexdigest
      @iteration += 1
    end
    return @hex_representation[5].to_i, @hex_representation[6]
  end

  def valid_hex_code?
    (begins_with_the_hex_key? &&
     set_within_password_length? &&
     password_value_unset?)
  end

  def begins_with_the_hex_key?
    @hex_representation.slice(0, 5) == @hex_key
  end

  def set_within_password_length?
    # a, b, c, d, e & f are hex for 10, 11, 12, 13, 14, 15
    !'abcdef'.include?(@hex_representation) &&
     @hex_representation[5].to_i < @password_length
  end

  def password_value_unset?
    @password[@hex_representation[5].to_i].nil?
  end

  def md5_hash
    @ssl_library.new(@ssl_protocol, "#{@code}#{@iteration}")
  end
end
