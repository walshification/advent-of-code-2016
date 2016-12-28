require 'yaml'

require 'day-07/ip'
require 'day-07/ip_parser'

RSpec.describe Ip do
  describe '#parse_tls' do
    context 'with Advent Code input' do
      it 'solves for tls' do
        advent_input = YAML.load_file('spec/fixtures/ips.yaml')
        advent_ips = advent_input.map { |input| Ip.new(input) }
        ip_parser = IpParser.new(advent_ips)
        expect(ip_parser.parse_tls.count).to eql(105)
      end
    end
  end

  describe '#parse_ssl' do
    context 'with Advent Code input' do
      it 'solves for ssh' do
        advent_input = YAML.load_file('spec/fixtures/ips.yaml')
        advent_ips = advent_input.map { |input| Ip.new(input) }
        ip_parser = IpParser.new(advent_ips)
        expect(ip_parser.parse_ssl.count).to eql(258)
      end
    end
  end
end
