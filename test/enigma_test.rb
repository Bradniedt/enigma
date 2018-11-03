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
    expected = [2, 27, 71, 15]
    assert_equal expected, enigma.get_shift_values('02715')
  end

  def test_it_can_get_final_shift_values
    enigma = Enigma.new
    expected = [3, 27, 73, 20]
    assert_equal expected, enigma.final_shift_values('02715', '040895')
  end

  def test_it_can_shift_a_value
    enigma = Enigma.new
    assert_equal 'c', enigma.shift(2, 'a')
  end

  def test_it_can_encrypt_messages
    enigma = Enigma.new
    actual = enigma.encrypt_message('hello world', '02715', '040895')
    assert_equal 'keder ohulw', actual
  end

  def test_it_can_get_todays_date
    enigma = Enigma.new
    assert_equal '031118', enigma.get_todays_date
  end

  def test_encrypt_can_return_a_hash_after_encryption
    enigma = Enigma.new
    actual = enigma.encrypt('hello world', '02715', '040895')
    expected = { encryption: "keder ohulw",
                 key: "02715",
                 date: "040895" }
    assert_equal expected, actual
  end

  def test_it_can_encrypt_if_no_key_or_date_are_given
    skip #test works, but will never pass because the key will always be random
    enigma = Enigma.new
    actual = enigma.encrypt('hello world')
    expected = { encryption: "keder ohulw",
                 key: "02715",
                 date: "031118" }
    assert_equal expected, actual
  end

  def test_it_can_encrypt_with_message_and_key_but_no_date
    enigma = Enigma.new
    actual = enigma.encrypt('hello world', '02715')
    expected = { encryption: "snddziogbuw",
                 key: "02715",
                 date: "031118" }
    assert_equal expected, actual
  end

  def test_it_can_encrypt_a_capitalized_message_and_output_downcased
    enigma = Enigma.new
    actual = enigma.encrypt('HELLO WORLD', '02715', '040895')
    expected = { encryption: "keder ohulw",
                 key: "02715",
                 date: "040895" }
    assert_equal expected, actual
  end

  def test_it_will_not_encrypt_punctuation
    enigma = Enigma.new
    actual = enigma.encrypt('hello world!', '02715', '040895')
    expected = { encryption: "keder ohulw!",
                 key: "02715",
                 date: "040895" }
    assert_equal expected, actual
  end

  def test_it_can_encrypt_messages_with_refactored_encrypt
    enigma = Enigma.new
    actual = enigma.encrypt_refactor('hello world', '02715', '040895')
    assert_equal 'keder ohulw', actual
  end
end
