require 'text_transformer'
require 'text_client'
# An intermediate class that acts as the interface between incoming HTTP
# requests, and the processing thereof.

class TextHandler
  # Take an incoming request and perform all the necessary processing on it
  def process(request)
    urls = body_from_request(request)
    text = TextClient.retrieve(urls)
    TextTransformer.transform(text)
  end

  # @return [String] the request body as a string
  def body_from_request(request)
    request.body.rewind # in case this has been read before
    request.body.read
  end
end
