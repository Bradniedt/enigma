class Enigma
  attr_reader :character_set
  def initialize
    @character_set = ('a'..'z').to_a << ' '
  end

  def get_key
    key = []
    5.times do
      key << rand(0..6)
    end
    key.join
  end


end
