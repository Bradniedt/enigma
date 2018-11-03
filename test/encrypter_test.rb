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
end
