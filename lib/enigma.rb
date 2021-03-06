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
    @shifter = Shifter.new
    @encrypter = Encrypter.new
    @decrypter = Decrypter.new
  end

  def get_todays_date
    date = Date.today
    today = date.strftime('%d%m%y')
  end

  def get_key
    key = []
    5.times do
      key << rand(0..9)
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
