require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exists
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
  end

  def test_it_has_a_character_set
    enigma = Enigma.new
    expected = ('a'..'z').to_a << " "
    assert_equal expected, enigma.character_set
  end

  def test_it_can_get_random_key
    enigma = Enigma.new
    assert_equal 5, enigma.get_key.length
    assert_instance_of Integer, enigma.get_key.to_i
  end

  def test_it_can_get_offset_values
    enigma = Enigma.new
    expected = [1, 0, 2, 5]
    assert_equal expected, enigma.get_offset_values('040895')
  end

  def test_it_can_get_shift_values
    enigma = Enigma.new
    expected = [3, 27, 73, 20]
    assert_equal expected, enigma.get_shift_values('02715')
  end
end
