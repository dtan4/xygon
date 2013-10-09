require 'openssl'
require 'digest'

module Xygon
  class Crypt
    def self.decrypt_file(cryptfile, rawfile, pass)
      once = decrypt_aes256(open(cryptfile).read, pass)
      decrypted = decrypt_aes256(once, pass.reverse)
      open(rawfile, "w") { |f| f.puts decrypted }
    end

    def self.encrypt_file(rawfile, cryptfile, pass)
      once = encrypt_aes256(open(rawfile).read, pass)
      encrypted = encrypt_aes256(once, pass.reverse)
      open(cryptfile, "w") { |f| f.puts encrypted }
    end

    def self.decrypt_aes256(text, pass)
      dec = OpenSSL::Cipher.new("AES-256-CBC")
      dec.decrypt
      dec.key = Digest::SHA256.digest(pass)
      dec.update(text) + dec.final
    end

    def self.encrypt_aes256(text, pass)
      enc = OpenSSL::Cipher.new("AES-256-CBC")
      enc.encrypt
      enc.key = Digest::SHA256.digest(pass)
      enc.update(text) + enc.final
    end
  end
end
