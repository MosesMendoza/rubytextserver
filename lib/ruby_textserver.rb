require 'sinatra'

class RubyTextserver
  # @return [String] the request body as a string
  def body_from_request(request)
    request.body.rewind # in case this has been read before
    request.body.read
  end

  # @param [String] a text string
  # @return [String] the same string with integers removed
  def remove_integers(text)
    # use the utf-8 compatible character-class rather than posix escape
    text.gsub(/[[:digit:]]/, '')
  end
#
#  def uniquify(body)
#
#  end
end
