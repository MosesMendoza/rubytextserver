require 'spec_helper'
require 'ruby_textserver'

describe RubyTextserver do
  let(:server) { RubyTextserver.new }

  describe "#body_from_request" do
    let(:body) { StringIO.new("foo") }
    let(:request) { double('request', :body => body) }
    # use a StringIO to simulate the IO object of a request body
    before { allow(request).to receive(:body).and_return(body) }

    it "should return the text body even if the request was already read" do
      # first issue a reqd such that we would have to rewind before reading
      request.body.read
      expect(server.body_from_request(request)).to eq("foo")
    end

    it "should return the text body of the request" do
      expect(server.body_from_request(request)).to eq("foo")
    end
  end

  describe "#remove_integers" do
    it "should return the given string without integers" do
      expect(server.remove_integers("abc123def099")).to eq("abcdef")
    end
  end

  describe "#uniquify" do
    it "should remove multiple instances of characters from the supplied string" do
      # might as well get some utf-8 exposure while we're at it
      string = "\u2603aaabb\u2603!!"
      expect(server.uniquify(string)).to eq("\u2603ab!")
    end
  end

  describe '#urls_from_text' do
    it "should return an array of URL strings from a text body" do
      url_string = "http://foo.bar,http://baz.qux"
      expect(server.urls_from_text(url_string)).to eq(["http://foo.bar", "http://baz.qux"])
    end
  end

end