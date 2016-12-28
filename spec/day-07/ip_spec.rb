require 'spec_helper'

require 'day-07/ip'

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

  describe '#supports_ssh?' do
    it 'return true if the silus compliments a hypernet' do
      ip = described_class.new('aba[bab]asd')
      expect(ip.supports_ssl?).to eql(true)
    end

    it 'returns false if the silus and hypernet do not compliment' do
      ip = described_class.new('aaa[aba]fff')
      expect(ip.supports_ssl?).to eql(false)
    end

    it 'cycles through multiple hypernets to find a compliment' do
      ip = described_class.new('aba[fff]yyy[bab]test')
      expect(ip.supports_ssl?).to eql(true)
    end

    it 'cycles through multiple siluses to find a compliment' do
      ip = described_class.new('test[fff]yyy[bab]aba')
      expect(ip.supports_ssl?).to eql(true)
    end

    it 'cycles through combinations on longer strings to find hypernets' do
      ip = described_class.new('test[fffabaf]yyy[babaaaa]bab')
      expect(ip.supports_ssl?).to eql(true)
    end

    it 'cycles through combinations on longer strings to find siluses' do
      ip = described_class.new('fffabaf[fffabaf]yyy[babaaaa]hhhhh')
      expect(ip.supports_ssl?).to eql(true)
    end

    it 'ignores noncomplimentary pairs' do
      ip = described_class.new('ffffff[ffffff]ffffff[fffff]ffffff')
      expect(ip.supports_ssl?).to eql(false)
    end
  end
end
