require 'spec_helper'
require 'text_client'

describe TextClient do
  let(:client) { TextClient.new }

  describe '#urls_from_text' do
    it "should return an array of URL strings from a text body" do
      url_string = "http://foo.bar,http://baz.qux"
      expect(client.urls_from_text(url_string)).to eq(["http://foo.bar", "http://baz.qux"])
    end
  end
end