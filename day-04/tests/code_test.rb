require './minitest_helper'
require './day-04/code'

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
