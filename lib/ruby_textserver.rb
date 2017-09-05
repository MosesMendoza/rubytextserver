require 'sinatra'

class RubyTextserver
  # @return [String] the request body as a string
  def body_from_request(request)
    request.body.rewind # in case this has been read before
    request.body.read
  end

#  def remove_integers(body)
#    
#  end
#
#  def uniquify(body)
#
#  end
end
