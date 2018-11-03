require './lib/shifter'

class Encrypter
  attr_reader :shifter
  def initialize
    @shifter = Shifter.new
  end

  def encrypt_message(message, key, date)
    shift_values = shifter.final_shift_values(key, date)
    letters = message.downcase.chars
    shifted_letters = []
    (letters.length).times do |i|
      if shifter.character_set.include?(letters[i])
        new_letter = shifter.shift(shift_values.rotate(i)[0], letters[i])
        shifted_letters << new_letter
      else
        shifted_letters << letters[i]
      end
    end
    shifted_letters.join
  end
end
