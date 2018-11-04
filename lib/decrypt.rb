require './lib/enigma'
encrypted_file, decrypted_file, key, date = ARGV
enigma = Enigma.new
message = open(encrypted_file, 'r+') { |f| f.read}
decryption = open(decrypted_file, "w")
result = enigma.decrypt(message, key, date)
decryption.write(result[:decryption])
p "Created 'decrypted.txt' with the key #{result[:key]} and date #{result[:date]}"
