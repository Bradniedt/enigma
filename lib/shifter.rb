class Shifter
  def initialize
    @character_set = ('a'..'z').to_a << ' '
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

  def unshift(shift_value, encrypted_letter)
    encrypted_letter_index = @character_set.index(encrypted_letter)
    rotated_characters = @character_set.rotate(-(shift_value))
    true_letter = rotated_characters[encrypted_letter_index]
  end
end
