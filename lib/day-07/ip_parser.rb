class IpParser
  def initialize(ip_addresses)
    @ip_addresses = ip_addresses
  end

  def parse
    @tls_supporters = @ip_addresses.select { |ip| ip.supports_tls? }
  end
end
