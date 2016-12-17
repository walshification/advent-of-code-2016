#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'

require_relative 'gps'

ADVENT_INPUT = "L4, L1, R4, R1, R1, L3, R5, L5, L2, L3, R2, R1, L4, R5, R4, "\
  "L2, R1, R3, L5, R1, L3, L2, R5, L4, L5, R1, R2, L1, R5, L3, R2, R2, L1, "\
  "R5, R2, L1, L1, R2, L1, R1, L2, L2, R4, R3, R2, L3, L188, L3, R2, R54, "\
  "R1, R1, L2, L4, L3, L2, R3, L1, L1, R3, R5, L1, R5, L1, L1, R2, R4, R4, "\
  "L5, L4, L1, R2, R4, R5, L2, L3, R5, L5, R1, R5, L2, R4, L2, L1, R4, R3, "\
  "R4, L4, R3, L4, R78, R2, L3, R188, R2, R3, L2, R2, R3, R1, R5, R1, L1, "\
  "L1, R4, R2, R1, R5, L1, R4, L4, R2, R5, L2, L5, R4, L3, L2, R1, R1, L5, "\
  "L4, R1, L5, L1, L5, L1, L4, L3, L5, R4, R5, R2, L5, R5, R5, R4, R2, L1, "\
  "L2, R3, R5, R5, R5, L2, L1, R4, R3, R1, L4, L2, L3, R2, L3, L5, L2, L2, "\
  "L1, L2, R5, L2, L2, L3, L1, R1, L4, R2, L4, R3, R5, R3, R4, R1, R5, L3, "\
  "L5, L5, L3, L2, L1, R3, L4, R3, R2, L1, R3, R1, L2, R4, L3, L3, L3, L1, L2"

class GpsTest < Minitest::Test
  def test_defaults_to_facing_north
    assert_equal(0, Gps.new.bearing)
  end

  def test_sets_inital_bearing_initialized_with_one
    assert_equal(3, Gps.new(3).bearing)
  end

  def test_knows_its_initial_coordinates_is_0_0
    assert_equal([0, 0], Gps.new.coordinates)
  end

  def test_advances_coordinates_based_on_bearing
    gps = Gps.new
    gps.advance

    assert_equal([0, 1], gps.coordinates)
  end

  def test_advances_along_x_axis_if_turned
    gps = Gps.new(1)
    gps.advance

    assert_equal([1, 0], gps.coordinates)
  end

  def test_advances_more_than_once_if_given_a_number
    gps = Gps.new
    gps.advance('A2')

    assert_equal([0, 2], gps.coordinates)
  end

  def test_turns_left_if_told_to_advance_with_L
    gps = Gps.new
    gps.advance('L1')

    assert_equal(3, gps.bearing)
  end

  def test_understands_a_string_of_commands
    gps = Gps.new
    gps.advance('L1, L4, R2')

    assert_equal([-3, -4], gps.coordinates)
  end

  def test_returns_how_many_blocks_from_start_you_are
    gps = Gps.new
    gps.advance('A4')

    assert_equal(4, gps.blocks_away)
  end

  def test_returns_blocks_away_for_string_of_commands
    gps = Gps.new
    gps.advance('L1, L4, R2')

    assert_equal(7, gps.blocks_away)
  end

  def test_understands_complicated_commands
    gps = Gps.new
    gps.advance('L4, L1, R4, R1, R1, L3, R5')

    assert_equal([-2, 3], gps.coordinates)
    assert_equal(5, gps.blocks_away)
  end

  def test_handles_3_digit_speeds
    gps = Gps.new
    gps.advance('L188')

    assert_equal([-188, 0], gps.coordinates)
  end

  def test_stops_if_it_reaches_a_point_already_visited
    gps = Gps.new
    gps.advance('R8, R4, R4, R8')

    assert_equal(4, gps.blocks_away)
  end

  def test_solves_the_puzzle
    gps = Gps.new
    gps.advance(ADVENT_INPUT)

    assert_equal(163, gps.blocks_away)
  end
end
