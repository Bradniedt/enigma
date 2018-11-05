require './lib/enigma'
message_file, encrypt_file = ARGV
enigma = Enigma.new
message = open(message_file, 'r') { |f| f.read}
encryption = open(encrypt_file, "w")
result = enigma.encrypt(message, enigma.get_key, enigma.get_todays_date)
encryption.write(result[:encryption])
p "Created 'encrypted.txt' with the key #{result[:key]} and date #{result[:date]}"
