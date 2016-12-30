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
    let(:screen) { KeycardScreen.new([
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
        ['.', '.', '.', '.', '.', '.', '.'],
      ]) }

    it 'turns pixels on when given a rect AxB command' do
      expected_screen = "###....\n"\
                        "###....\n"\
                        ".......\n"

      expect(screen.scan_keycard('rect 3x2')).to eql(expected_screen)
    end

    it 'rotates a specified column by a specified amount' do
      expected_screen = "#.#....\n"\
                        "###....\n"\
                        ".#.....\n"

      screen.scan_keycard('rect 3x2')
      screen.scan_keycard('rotate column x=1 by 1')
      expect(screen.window).to eql(expected_screen)
    end
  end
end
