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
end
