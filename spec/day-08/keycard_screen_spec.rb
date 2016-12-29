require 'spec_helper'

require 'day-08/keycard_screen'

RSpec.describe KeycardScreen do
  describe '#window' do
    it 'defaults to a 50x6 pixel screen' do
      screen = KeycardScreen.new
      expected_display = "#{'.' * 50}\n" * 6
      expect(screen.window).to eql(expected_display)
    end

    it 'changes screen layout if created with a different one' do
      new_screen = [['.']]
      screen = KeycardScreen.new(new_screen)
      expect(screen.window).to eql(".\n")
    end
  end

  describe '#scan_keycard' do
    it 'turns pixels on when given a rect AxB command' do
      screen = KeycardScreen.new([
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
        ['.', '.', '.', '.'],
      ])
      expected_screen = "XXX.\nXXX.\n....\n....\n"
      screen.scan_keycard('rect 3x2')
      expect(screen.window).to eql(expected_screen)
    end
  end
end
