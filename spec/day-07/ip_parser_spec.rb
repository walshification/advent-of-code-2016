require 'yaml'

require 'day-07/ip'
require 'day-07/ip_parser'

RSpec.describe Ip do
  describe '#supports_tls?' do
    it 'returns true if an abba pattern is in the silus' do
      ip = described_class.new('abba[test]onew')
      expect(ip.supports_tls?).to eql(true)
    end

    it 'returns true if an abba is found inside a longer sequence' do
      ip = described_class.new('fabbas[test]onew')
      expect(ip.supports_tls?).to eql(true)
    end

    it 'returns false if an abba cannot be found' do
      ip = described_class.new('fabb[test]onew')
      expect(ip.supports_tls?).to eql(false)
    end

    it 'returns false if the hypernet sequence contains an abba' do
      ip = described_class.new('abba[ghhg]onew')
      expect(ip.supports_tls?).to eql(false)
    end

    it 'checks more than one hypernet sequence' do
      ip = described_class.new('zjav[fkmx]yffy[qhhq]sbnv')
      expect(ip.supports_tls?).to eql(false)
    end
  end

  context 'with Advent Code input' do
    it 'solves the puzzle' do
      advent_input = YAML.load_file('spec/fixtures/ips.yaml')
      advent_ips = advent_input.map { |input| Ip.new(input) }
      ip_parser = IpParser.new(advent_ips)
      expect(ip_parser.parse.count).to eql(105)
    end
  end
end
