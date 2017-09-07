# A class to handle the parsing of text from a request

class RubyTextserver
  # @return [String] the request body as a string
  def body_from_request(request)
    request.body.rewind # in case this has been read before
    request.body.read
  end

  # @param [String] a comma-separated list of URLs
  # @return [Array] an array of URL strings
  def urls_from_text(text)
    text.split(',')
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
    # Use a set to establish the character string
    set = Set.new(body.chars)
    # sets don't have join but arrays do. this transformation is based on the
    # assumption that it is faster to convert to an array and join than reduce
    # over the set appending to the new string.
    set.to_a.join
  end
end
