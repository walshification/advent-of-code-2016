class IpParser
  def initialize(ip_addresses)
    @ip_addresses = ip_addresses
  end

  def parse_tls
    @tls_supporters = @ip_addresses.select { |ip| ip.supports_tls? }
  end

  def parse_ssl
    @ssh_supporters = @ip_addresses.select { |ip| ip.supports_ssl? }
  end

  def supports_all_security?
    parse_tls & parse_ssh
  end
end
