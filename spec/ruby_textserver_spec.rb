require 'spec_helper'
require 'ruby_textserver'

describe RubyTextserver do
  describe '#body_from_request' do
    let(:server) { RubyTextserver.new }
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
end