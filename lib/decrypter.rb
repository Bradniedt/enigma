require './lib/shifter'
class Decrypter
  attr_reader :shifter
  def initialize
    @shifter = Shifter.new
  end

end
