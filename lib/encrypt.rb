require './lib/enigma'
message_file, encrypt_file = ARGV
enigma = Enigma.new
message = open(message_file, 'r+') { |f| f.read}
encryption = open(encrypt_file, "w")
