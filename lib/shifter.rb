class Shifter

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
end
