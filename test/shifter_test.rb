require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/shifter'

class ShifterTest < Minitest::Test
  def test_it_exists
    shifter = Shifter.new
    assert_instance_of Shifter, shifter
  end

  def test_it_can_get_offset_values
    shifter = Shifter.new
    expected = [1, 0, 2, 5]
    assert_equal expected, shifter.get_offset_values('040895')
  end

  def test_it_can_get_shift_values
    shifter = Shifter.new
    expected = [2, 27, 71, 15]
    assert_equal expected, shifter.get_shift_values('02715')
  end

  def test_it_can_get_final_shift_values
    shifter = Shifter.new
    expected = [3, 27, 73, 20]
    assert_equal expected, shifter.final_shift_values('02715', '040895')
  end
end
