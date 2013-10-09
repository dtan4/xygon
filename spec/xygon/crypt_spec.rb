# -*- coding: utf-8 -*-
require "spec_helper"

module Xygon
  describe Crypt do
    let(:rawfile) { File.expand_path("../fixtures/raw", __dir__) }
    let(:cryptfile) { File.expand_path("../fixtures/crypt", __dir__) }
    let(:encrypted) { File.expand_path("../fixtures/encrypted", __dir__) }
    let(:decrypted) { File.expand_path("../fixtures/decrypted", __dir__) }
    let(:pass) { "abcd1234" }

    describe "#decrypt_file" do
      before do
        pending "encrypted file is invalid now"
        Xygon::Crypt.decrypt_file(cryptfile, decrypted, pass)
      end

      it "should generate decrypted file" do
        File.exists?(decrypted).should be_true
      end

      it "should return the same to raw file" do
        open(decrypted).read.should == open(rawfile).read
      end

      after do
        File.delete(decrypted) if File.exists?(decrypted)
      end
    end

    describe "#encrypt_file" do
      before do
        pending "encrypted file is invalid now"
        Xygon::Crypt.encrypt_file(rawfile, encrypted, pass)
      end

      it "should generate encrypted file" do
        File.exists?(encrypted).should be_true
      end

      it "should return the same to crypt file" do
        open(encrypted).read.force_encoding("ascii-8bit").strip.should == open(cryptfile).read.force_encoding("ascii-8bit").strip
      end

      after do
        File.delete(encrypted) if File.exists?(encrypted)
      end
    end

    let(:raw_str) { "hogehoge" }
    let(:encrypted_str) { open(File.expand_path("../fixtures/encrypted_str", __dir__)).read.force_encoding("ascii-8bit").strip }

    describe "#decrypt_aes256" do
      it "should decrypt the AES-256 encrypted string" do
        Xygon::Crypt.decrypt_aes256(encrypted_str, pass).should == raw_str
      end
    end

    describe "#encrypt_aes256" do
      it "should encrypt string using AES-256 method" do
        Xygon::Crypt.encrypt_aes256(raw_str, pass).should == encrypted_str
      end
    end
  end
end
