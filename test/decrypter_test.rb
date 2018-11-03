require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/Decrypter'

class DecrypterTest < Minitest::Test
  def test_it_exists
    decrypter = Decrypter.new
    assert_instance_of Decrypter, decrypter
  end

  def test_it_has_a_shifter
    decrypter = Decrypter.new
    assert_instance_of Shifter, decrypter.shifter
  end

  def test_it_has_a_character_set
    decrypter = Decrypter.new
    expected = ('a'..'z').to_a << " "
    assert_equal expected, decrypter.shifter.character_set
  end

  def test_it_can_get_offset_values
    decrypter = Decrypter.new
    expected = [1, 0, 2, 5]
    assert_equal expected, decrypter.shifter.get_offset_values('040895')
  end

  def test_it_can_get_shift_values
    decrypter = Decrypter.new
    expected = [2, 27, 71, 15]
    assert_equal expected, decrypter.shifter.get_shift_values('02715')
  end

  def test_it_can_get_final_shift_values
    decrypter = Decrypter.new
    expected = [3, 27, 73, 20]
    assert_equal expected, decrypter.shifter.final_shift_values('02715', '040895')
  end

  def test_it_can_shift_a_value
    decrypter = Decrypter.new
    assert_equal 'c', decrypter.shifter.shift(2, 'a')
  end

  def test_it_can_unshift_a_value
    decrypter = Decrypter.new
    assert_equal 'a', decrypter.shifter.unshift(2, 'c')
  end

  def test_it_can_decrypt
    decrypter = Decrypter.new
    actual = decrypter.decrypt_message('keder ohulw', '02715', '040895')
    assert_equal 'hello world', actual
  end

  def test_it_can_decrypt_messages_with_punctuation
    decrypter = Decrypter.new
    actual = decrypter.decrypt_message('keder ohulw!', '02715', '040895')
    assert_equal 'hello world!', actual
  end
end
