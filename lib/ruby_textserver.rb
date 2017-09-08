# A class to handle the parsing of text from a request

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

  # @param [String] a text string
  # @return [String] the supplied text string with only a single instance of
  #   any character in the supplied string
  def uniquify(body)
    # we don't use a set here because ruby Set doesn't have a '#join' method
    # so we make it an array of chars and uniq it, and then join afterward
    set = body.chars.uniq
    set.join
  end
end
