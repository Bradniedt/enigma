class Shifter

  def get_offset_values(date)
    offsets = []
    square = date.to_i * date.to_i
    last_four = square.to_s.slice(-4..-1).chars
    4.times {|i| offsets << last_four[i].to_i}
    offsets
  end
end
