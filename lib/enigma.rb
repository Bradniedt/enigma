require 'date'
class Enigma
  attr_reader :character_set
  def initialize
    @character_set = ('a'..'z').to_a << ' '
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

  def get_offset_values(date)
    offsets = []
    square = date.to_i * date.to_i
    last_four = square.to_s.slice(-4..-1).chars
    4.times {|i| offsets << last_four[i].to_i}
    offsets
  end

  def get_shift_values(key)
    key_values = key.chars
    key_numbers = []
    (key_values.length - 1).times do |index|
      key_numbers << ("#{key_values[index]}#{key_values[index + 1]}").to_i
    end
    key_numbers
  end

  def final_shift_values(key, date)
    key_numbers = get_shift_values(key)
    offset_values = get_offset_values(date)
    final_values = []
    4.times {|index| final_values << key_numbers[index] + offset_values[index]}
    final_values
  end

  def shift(shift_value, letter)
    letter_index = @character_set.index(letter)
    rotated_characters = @character_set.rotate(shift_value)
    new_letter = rotated_characters[letter_index]
  end

  def encrypt_message(message, key, date)
    shift_values = final_shift_values(key, date)
    letters = message.downcase.chars
    shifted_letters = []
    letters.each_index do |index|
      letter = letters[index]
      if @character_set.include?(letter)
        if index % 4 == 0
          shifted_letters << shift(shift_values[0], letter)
        elsif index % 4 == 1
          shifted_letters << shift(shift_values[1], letter)
        elsif index % 4 == 2
          shifted_letters << shift(shift_values[2], letter)
        elsif index % 4 == 3
          shifted_letters << shift(shift_values[3], letter)
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
    shift_values = final_shift_values(key, date)
    letters = message.downcase.chars
    shifted_letters = []
    (letters.length).times do |i|
      if @character_set.include?(letters[i])
        new_letter = shift(shift_values.rotate(i)[0], letters[i])
        shifted_letters << new_letter
      else
        shifted_letters << letters[i]
      end
    end
    shifted_letters.join
  end

  def unshift(shift_value, encrypted_letter)
    encrypted_letter_index = @character_set.index(encrypted_letter)
    rotated_characters = @character_set.rotate(-(shift_value))
    true_letter = rotated_characters[encrypted_letter_index]
  end

  def decrypt_message(encrypted_message, key, date)
    shift_values = final_shift_values(key, date)
    encrypted_letters = encrypted_message.chars
    unshifted_letters = []
    (encrypted_letters.length).times do |i|
      if @character_set.include?(encrypted_letters[i])
        true_letter = unshift(shift_values.rotate(i)[0], encrypted_letters[i])
        unshifted_letters << true_letter
      else
        unshifted_letters << encrypted_letters[i]
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
