require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/enigma'

class ShifterTest < Minitest::Test
  def test_it_exists
    shifter = Shifter.new
    assert_instance_of Shifter, shifter
  end 
end
