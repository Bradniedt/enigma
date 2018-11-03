require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/encrypter'

class EncrypterTest < Minitest::Test
  def test_it_exists
    encrypter = Encrypter.new
    assert_instance_of Encrypter, encrypter
  end

  def test_it_has_a_shifter
    encrypter = Encrypter.new
    assert_instance_of Shifter, encrypter.shifter
  end

  def test_it_has_a_character_set
    encrypter = Encrypter.new
    expected = ('a'..'z').to_a << " "
    assert_equal expected, encrypter.shifter.character_set
  end

  def test_it_can_get_offset_values
    encrypter = Encrypter.new
    expected = [1, 0, 2, 5]
    assert_equal expected, encrypter.shifter.get_offset_values('040895')
  end

  def test_it_can_get_shift_values
    encrypter = Encrypter.new
    expected = [2, 27, 71, 15]
    assert_equal expected, encrypter.shifter.get_shift_values('02715')
  end

  def test_it_can_get_final_shift_values
    encrypter = Encrypter.new
    expected = [3, 27, 73, 20]
    assert_equal expected, encrypter.shifter.final_shift_values('02715', '040895')
  end

  def test_it_can_shift_a_value
    encrypter = Encrypter.new
    assert_equal 'c', encrypter.shifter.shift(2, 'a')
  end
end
