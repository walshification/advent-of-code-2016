#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'

require 'yaml'
require_relative 'sector_sum'

ADVENT_INPUT = YAML.load_file('day-04/advent_input.yaml')

class SectorSumTests < Minitest::Test
  def test_catalogs_a_list_of_room_codes
    codes = [
      Code.new('bkwzkqsxq-tovvilokx-nozvyiwoxd-172[fstek]'),
      Code.new('wifilzof-wbiwifuny-yhachyylcha-526[qrazx]'),
    ]
    sector_sum = SectorSum.new(codes)
    assert_equal(codes, sector_sum.codes)
  end

  def test_sums_sector_ids_of_real_rooms
    codes = [
      Code.new('test-code-100[etcdo]'),
      Code.new('test-code-123[etcdo]'),
    ]
    sector_sum = SectorSum.new(codes)
    assert_equal(223, sector_sum.sum_codes)
  end

  def test_skips_summing_secotr_ids_of_fake_rooms
    sector_sum = SectorSum.new([Code.new('test-code-123[besty]')])
    assert_equal(0, sector_sum.sum_codes)
  end

  def test_solves_the_puzzle
    advent_codes = ADVENT_INPUT.map { |code| Code.new(code) }
    sector_sum = SectorSum.new(advent_codes)
    assert_equal(185371, sector_sum.sum_codes)
  end
end

class CodeTests < Minitest::Test
  def test_parses_the_code_for_its_encrypted_name
    code = Code.new('test-code-123[besty]')
    assert_equal('testcode', code.encrypted_name)
  end

  def test_parses_the_code_for_its_sector_id
    code = Code.new('test-code-123[besty]')
    assert_equal(123, code.sector_id)
  end

  def test_parses_the_code_for_its_sector_id
    code = Code.new('test-code-123[besty]')
    assert_equal('besty', code.checksum)
  end

  def test_knows_code_is_not_real_with_invalid_checksum
    code = Code.new('test-code-123[besty]')
    assert_equal(false, code.real?)
  end

  def test_knows_code_is_real_with_valid_checksum
    code = Code.new('test-code-123[etcdo]')
    assert_equal(true, code.real?)
  end
end
