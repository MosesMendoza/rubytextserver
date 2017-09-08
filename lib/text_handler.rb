# An intermediate class that acts as the interface between incoming HTTP
# requests, and the processing thereof.

class TextHandler
  # @return [String] the request body as a string
  def body_from_request(request)
    request.body.rewind # in case this has been read before
    request.body.read
  end
end
