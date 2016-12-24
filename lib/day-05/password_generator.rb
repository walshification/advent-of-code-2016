class PasswordGenerator
  def initialize(code, options=nil)
    options ||= {}
    @code = code
    @iteration = 0
    @ssl_library = options.fetch(:ssl_library, OpenSSL::Digest)
    @ssl_protocol = options.fetch(:ssl_protocol, 'MD5')
    @password_length = options.fetch(:password_length, 8)
    @hex_key = options.fetch(:hex_key, '00000')
    @password = []
  end

  def generate
    until @password.length == @password_length
      @password << hash_code
    end
    @password.join
  end

  private

  def hash_code
    hex_representation = ''
    until hex_representation.slice(0, 5) == @hex_key
      hex_representation = md5_hash.hexdigest
      @iteration += 1
    end
    hex_representation[5]
  end

  def md5_hash
    @ssl_library.new(@ssl_protocol, "#{@code}#{@iteration}")
  end
end
