require 'date'
require './lib/shifter'
class Enigma
  attr_reader :character_set,
              :shifter
  def initialize
    @character_set = ('a'..'z').to_a << ' '
    @shifter = Shifter.new
  end

  def get_todays_date
    date = Date.today
    day = date.strftime('%d')
    month = date.strftime('%m')
    year = date.strftime('%y')
    today = "#{day}#{month}#{year}"
  end

  def get_key
    key = []
    5.times do
      key << rand(0..6)
    end
    key.join
  end

  def encrypt_message(message, key, date)
    shift_values = shifter.final_shift_values(key, date)
    letters = message.downcase.chars
    shifted_letters = []
    letters.each_index do |index|
      letter = letters[index]
      if @character_set.include?(letter)
        if index % 4 == 0
          shifted_letters << shifter.shift(shift_values[0], letter)
        elsif index % 4 == 1
          shifted_letters << shifter.shift(shift_values[1], letter)
        elsif index % 4 == 2
          shifted_letters << shifter.shift(shift_values[2], letter)
        elsif index % 4 == 3
          shifted_letters << shifter.shift(shift_values[3], letter)
        end
      else
        shifted_letters << letter
      end
    end
    shifted_letters.join
  end

  def encrypt(message, key = get_key, date = get_todays_date)
    encryption_return = { encryption: encrypt_refactor(message, key, date),
                         key: key,
                         date: date }
  end

  def encrypt_refactor(message, key, date)
    shift_values = shifter.final_shift_values(key, date)
    letters = message.downcase.chars
    shifted_letters = []
    (letters.length).times do |i|
      if @character_set.include?(letters[i])
        new_letter = shifter.shift(shift_values.rotate(i)[0], letters[i])
        shifted_letters << new_letter
      else
        shifted_letters << letters[i]
      end
    end
    shifted_letters.join
  end

  def decrypt_message(encrypted_message, key, date)
    shift_values = shifter.final_shift_values(key, date)
    letters = encrypted_message.chars
    unshifted_letters = []
    (letters.length).times do |i|
      if @character_set.include?(letters[i])
        true_letter = shifter.unshift(shift_values.rotate(i)[0], letters[i])
        unshifted_letters << true_letter
      else
        unshifted_letters << letters[i]
      end
    end
    unshifted_letters.join
  end

  def decrypt(encrypted_message, key, date = get_todays_date)
    decryption_return = { decryption: decrypt_message( encrypted_message,
                                                       key,
                                                       date ),
                         key: key,
                         date: date }
  end
end
