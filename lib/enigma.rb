require 'date'
require './lib/shifter'
require './lib/encrypter'
require './lib/decrypter'
class Enigma
  attr_reader :character_set,
              :shifter,
              :encrypter,
              :decrypter
  def initialize
    @character_set = ('a'..'z').to_a << ' '
    @shifter = Shifter.new
    @encrypter = Encrypter.new
    @decrypter = Decrypter.new
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

  def encrypt(message, key = get_key, date = get_todays_date)
    encryption = { encryption: encrypter.encrypt_message(message, key, date),
                   key: key,
                   date: date }
  end

  def decrypt(encrypted_message, key, date = get_todays_date)
    decryption = { decryption: decrypter.decrypt_message( encrypted_message,
                                                          key,
                                                          date ),
                   key: key,
                   date: date }
  end
end
