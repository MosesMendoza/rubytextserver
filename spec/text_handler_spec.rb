require 'spec_helper'
require 'text_handler'

describe TextHandler do
  let(:handler) { TextHandler.new }

  describe "#body_from_request" do
    let(:body) { StringIO.new("foo") }
    let(:request) { double('request', :body => body) }
    # use a StringIO to simulate the IO object of a request body
    before { allow(request).to receive(:body).and_return(body) }

    it "should return the text body even if the request was already read" do
      # first issue a reqd such that we would have to rewind before reading
      request.body.read
      expect(handler.body_from_request(request)).to eq("foo")
    end

    it "should return the text body of the request" do
      expect(handler.body_from_request(request)).to eq("foo")
    end
  end
end