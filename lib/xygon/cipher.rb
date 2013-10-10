require 'openssl'
require 'digest'

module Xygon
  class Cipher
    def self.decrypt_file(encrypted_file, raw_file, pass)
      once = decrypt_aes256(open(encrypted_file, "rb").read.strip, pass.reverse)
      decrypted = decrypt_aes256(once, pass)
      open(raw_file, "w") { |f| f.puts decrypted }
    end

    def self.encrypt_file(raw_file, encrypted_file, pass)
      once = encrypt_aes256(open(raw_file).read, pass)
      encrypted = encrypt_aes256(once, pass.reverse)
      open(encrypted_file, "w") { |f| f.puts encrypted }
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

    def self.get_sha256(text)
      Digest::SHA256.hexdigest(text)
    end
  end
end
