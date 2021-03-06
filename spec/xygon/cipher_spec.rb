# -*- coding: utf-8 -*-
require "spec_helper"

module Xygon
  describe Cipher do
    let(:raw) { File.expand_path("../fixtures/raw", __dir__) }
    let(:encrypted) { File.expand_path("../fixtures/encrypted", __dir__) }
    let(:_encrypted) { File.expand_path("../fixtures/_encrypted", __dir__) }
    let(:_decrypted) { File.expand_path("../fixtures/_decrypted", __dir__) }
    let(:pass) { "abcd1234" }

    describe "#decrypt_file" do
      before do
        Xygon::Cipher.decrypt_file(encrypted, _decrypted, pass)
      end

      it "should generate decrypted file" do
        File.exists?(_decrypted).should be_true
      end

      it "should return the same to raw file" do
        open(_decrypted).read.should == open(raw).read
      end

      after do
        File.delete(_decrypted) if File.exists?(_decrypted)
      end
    end

    describe "#encrypt_file" do
      before do
        Xygon::Cipher.encrypt_file(raw, _encrypted, pass)
      end

      it "should generate _encrypted file" do
        File.exists?(_encrypted).should be_true
      end

      it "should return the same to crypt file" do
        read_as_binary(_encrypted).should == read_as_binary(encrypted)
      end

      after do
        File.delete(_encrypted) if File.exists?(_encrypted)
      end
    end

    let(:raw_str) { "hogehoge" }
    let(:encrypted_str) { read_as_binary(File.expand_path("../fixtures/encrypted_str", __dir__)) }

    describe "#decrypt_aes256" do
      it "should decrypt the AES-256 encrypted string" do
        Xygon::Cipher.decrypt_aes256(encrypted_str, pass).should == raw_str
      end
    end

    describe "#encrypt_aes256" do
      it "should encrypt string" do
        Xygon::Cipher.encrypt_aes256(raw_str, pass).should == encrypted_str
      end
    end

    let(:password) { "password" }
    let(:invalid_password) { password + "aaa" }
    let(:password_digest) { "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8" }

    describe "#get_sha256" do
      it "should generate SHA256 digest" do
        Xygon::Cipher.get_sha256(password).should == password_digest
      end
    end

    describe "#digest_match?" do
      it "should call #get_sha256" do
        Xygon::Cipher.should_receive(:get_sha256)
        Xygon::Cipher.digest_match?(pass, password_digest)
      end

      context "with valid password" do
        it "should return true" do
          Xygon::Cipher.digest_match?(password, password_digest).should be_true
        end
      end

      context "with invalid password" do
        it "should return false" do
          Xygon::Cipher.digest_match?(invalid_password, password_digest).should be_false
        end
      end
    end
  end
end
