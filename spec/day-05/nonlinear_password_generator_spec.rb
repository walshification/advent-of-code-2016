require 'spec_helper'

require 'day-05/nonlinear_password_generator'

RSpec.describe NonlinearPasswordGenerator do
  describe '#generate' do
    before(:each) do
      @hash_1 = double('fake hash')
      @hash_2 = double('second hash')
      expect(OpenSSL::Digest).to receive(:new).with('MD5', 'test0') { @hash_1 }
      expect(OpenSSL::Digest).to receive(:new).with('MD5', 'test1') { @hash_2 }
    end

    it 'skips hex codes that do not start with 00000' do
      allow(@hash_1).to receive(:hexdigest) { '111110f' }
      allow(@hash_2).to receive(:hexdigest) { '000000a' }

      generator = NonlinearPasswordGenerator.new('test', password_length: 1)

      # skips the 'f' value and saves 'a'
      expect(generator.generate).to eql('a')
    end

    it 'skips hex codes to be positioned passed the length of the password' do
      allow(@hash_1).to receive(:hexdigest) { '000001f' }
      allow(@hash_2).to receive(:hexdigest) { '000000a' }

      generator = NonlinearPasswordGenerator.new('test', password_length: 1)

      # skips 'f' because index 1 is longer than a 1-character password
      expect(generator.generate).to eql('a')
    end

    it 'skips hex codes that would replace a character already set' do
      hash_3 = double('third hash')
      expect(OpenSSL::Digest).to receive(:new).with('MD5', 'test2') { hash_3 }
      allow(@hash_1).to receive(:hexdigest) { '000001f' }
      allow(@hash_2).to receive(:hexdigest) { '000001a' }
      allow(hash_3).to receive(:hexdigest) { '000000b' }

      generator = NonlinearPasswordGenerator.new('test', password_length: 2)

      # skips 'a' because 'f' is already set to index 1
      expect(generator.generate).to eql('bf')
    end
  end

  context 'with Advent Code input' do
    it 'solves the puzzle',
    :skip => 'generator takes too long to run for testing' do
      generator = NonlinearPasswordGenerator.new('ojvtpuvg')
      expect(generator.generate).to eql('1050cbbd')
    end
  end
end
