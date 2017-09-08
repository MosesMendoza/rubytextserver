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

  describe '#retrieve_text' do
    it "should issue obtain the text at the provided URL" do
      url = "http://foo.com"
      expect(Net::HTTP).to receive(:get).with(URI(url))
      client.retrieve_text(url)
    end
  end

  describe "retrieve_text_from_urls" do
    it "should retrieve text from multiple urls and aggregate the response" do
      # We are going to return different things from #retrieve_text and expect
      # that the aggregate of the is returned
      expect(client).to receive(:retrieve_text).and_return("foo").exactly(4).times
      # it doesn't matter what these urls are, what matters is how many we pass
      urls = [:a, :b, :c, :d]
      expect(client.retrieve_text_from_urls(urls)).to eq("foofoofoofoo")
    end
  end
end