require 'spec_helper'

require 'day-05/password_generator'

RSpec.describe PasswordGenerator do
  subject { PasswordGenerator.new('abc') }

  describe '#generate' do
    it 'hashes a door code incrementally' do
      digest = double('fake hash code')
      allow(digest).to receive(:hexdigest) { '000001' }

      expect(OpenSSL::Digest).to receive(:new).with('MD5', 'abc0') { digest }
      expect(OpenSSL::Digest).to receive(:new).with('MD5', 'abc1') { digest }

      PasswordGenerator.new('abc', { password_length: 2 }).generate
    end

    it 'returns the sixth value in the hex value if the hex begins with 00000' do
      digest = double('fake hash code')
      allow(digest).to receive(:hexdigest) { '000001' }
      allow(OpenSSL::Digest).to receive(:new) { digest }

      password = subject.generate
      expect(password).to eql('11111111')
    end
  end

  context 'with Advent Code input' do
    skip 'solves the puzzle' do
      expect(PasswordGenerator.new('ojvtpuvg').generate).to eql('4543c154')
    end
  end
end
