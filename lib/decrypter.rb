require './lib/shifter'
class Decrypter
  attr_reader :shifter
  def initialize
    @shifter = Shifter.new
  end

  def decrypt_message(encrypted_message, key, date)
    shift_values = shifter.final_shift_values(key, date)
    letters = encrypted_message.chars
    unshifted_letters = []
    (letters.length).times do |i|
      if shifter.character_set.include?(letters[i])
        true_letter = shifter.unshift(shift_values.rotate(i)[0], letters[i])
        unshifted_letters << true_letter
      else
        unshifted_letters << letters[i]
      end
    end
    unshifted_letters.join
  end
end
