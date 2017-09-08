require 'spec_helper'
require 'text_transformer'

describe TextTransformer do
  describe "::remove_integers" do
    it "should return the given string without integers" do
      expect(TextTransformer.remove_integers("abc123def099")).to eq("abcdef")
    end
  end

  describe "::uniquify" do
    it "should remove multiple instances of characters from the supplied string" do
      # might as well get some utf-8 exposure while we're at it
      string = "\u2603aaabb\u2603!!"
      expect(TextTransformer.uniquify(string)).to eq("\u2603ab!")
    end
  end
end