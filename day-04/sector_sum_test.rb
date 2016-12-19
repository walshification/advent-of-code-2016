#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'

require 'yaml'
require_relative 'sector_sum'

ADVENT_INPUT = YAML.load_file('day-04/advent_input.yaml')

class SectorSumTests < Minitest::Test
  def test_catalogs_a_list_of_room_codes
    codes = [
      'bkwzkqsxq-tovvilokx-nozvyiwoxd-172[fstek]',
      'wifilzof-wbiwifuny-yhachyylcha-526[qrazx]',
    ]
    sector_sum = SectorSum.new(codes)
    assert_equal(codes, sector_sum.codes)
  end
end
