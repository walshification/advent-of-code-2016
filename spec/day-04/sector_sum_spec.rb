require 'yaml'

require 'day-04/sector_sum'



# ADVENT_INPUT = YAML.load_file('day-04/advent_input.yaml')

# class SectorSumTests < Minitest::Test
#   def test_catalogs_a_list_of_room_codes
#     codes = [
#       Code.new('bkwzkqsxq-tovvilokx-nozvyiwoxd-172[fstek]'),
#       Code.new('wifilzof-wbiwifuny-yhachyylcha-526[qrazx]'),
#     ]
#     sector_sum = SectorSum.new(codes)
#     assert_equal(codes, sector_sum.codes)
#   end

#   def test_sums_sector_ids_of_real_rooms
#     codes = [
#       Code.new('test-code-100[etcdo]'),
#       Code.new('test-code-123[etcdo]'),
#     ]
#     sector_sum = SectorSum.new(codes)
#     assert_equal(223, sector_sum.sum_codes)
#   end

#   def test_skips_summing_secotr_ids_of_fake_rooms
#     sector_sum = SectorSum.new([Code.new('test-code-123[besty]')])
#     assert_equal(0, sector_sum.sum_codes)
#   end

#   def test_solves_the_puzzle
#     advent_codes = ADVENT_INPUT.map { |code| Code.new(code) }
#     sector_sum = SectorSum.new(advent_codes)
#     assert_equal(185371, sector_sum.sum_codes)
#   end
# end
