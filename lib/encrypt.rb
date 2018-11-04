to_encrypt = ARGV.first
encrypted = ARGV.second
require './lib/enigma'
require 'pry'
enigma = Enigma.new
message = open(to_encrypt, 'r+') { |f| f.read}
encryption = open(encrypted, "r+")
result = Enigma.encrypt(message, enigma.get_key, enigma.get_todays_date)
encryption.write(result[:encryption])
