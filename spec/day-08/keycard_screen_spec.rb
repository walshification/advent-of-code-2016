require 'yaml'

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

    context '1 pixel' do
      it 'turns a single pixel' do
        expected_screen = "#......\n"\
                          ".......\n"\
                          ".......\n"

        screen.scan_keycard(['rect 1x1'])
        expect(screen.window).to eql(expected_screen)
      end

      it 'can rotate a column by more than 1' do
        expected_screen = ".......\n"\
                          ".......\n"\
                          "#......\n"

        screen.scan_keycard(['rect 1x1'])
        screen.scan_keycard(['rotate column x=0 by 2'])
        expect(screen.window).to eql(expected_screen)
      end
    end

    context 'with a block of pixels' do
      before(:each) do
        screen.scan_keycard(['rect 3x2'])
      end

      it 'turns pixels on when given a rect AxB command' do
        expected_screen = "###....\n"\
                          "###....\n"\
                          ".......\n"

        expect(screen.window).to eql(expected_screen)
      end

      it 'rotates a specified column by a specified amount' do
        expected_screen = "#.#....\n"\
                          "###....\n"\
                          ".#.....\n"

        screen.scan_keycard(['rotate column x=1 by 1'])
        expect(screen.window).to eql(expected_screen)
      end

      it 'rotates a specified row by a specified amount' do
        expected_screen = "....#.#\n"\
                          "###....\n"\
                          ".#.....\n"

        screen.scan_keycard(['rotate column x=1 by 1'])
        screen.scan_keycard(['rotate row y=0 by 4'])
        expect(screen.window).to eql(expected_screen)
      end

      it 'wraps pixels around when they go past the end of the screen' do
        expected_screen = ".#..#.#\n"\
                          "#.#....\n"\
                          ".#.....\n"

        screen.scan_keycard(['rotate column x=1 by 1'])
        screen.scan_keycard(['rotate row y=0 by 4'])
        screen.scan_keycard(['rotate column x=1 by 1'])
        expect(screen.window).to eql(expected_screen)
      end

      it 'wraps pixels around rows' do
        expected_screen = "#....#.\n"\
                          "###....\n"\
                          ".#.....\n"

        screen.scan_keycard(['rotate column x=1 by 1'])
        screen.scan_keycard(['rotate row y=0 by 5'])
        expect(screen.window).to eql(expected_screen)
      end

      it 'accepts more than one command at a time' do
        expected_screen = ".#..#.#\n"\
                          "#.#....\n"\
                          ".#.....\n"
        commands = [
          'rotate column x=1 by 1',
          'rotate row y=0 by 4',
          'rotate column x=1 by 1',
        ]

        screen.scan_keycard(commands)
        expect(screen.window).to eql(expected_screen)
      end
    end
  end

  context 'with Advent Code input' do
    it 'solves the puzzle' do
      advent_commands = YAML.load_file('./spec/fixtures/keycard_input.yaml')
      advent_screen = described_class.new
      advent_screen.scan_keycard(advent_commands)
      expect(advent_screen.window.count('#')).to eql(110)
    end
  end
end
