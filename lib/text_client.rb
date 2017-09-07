# A class to retrieve text from urls

class TextClient
    # @param [String] a comma-separated list of URLs
  # @return [Array] an array of URL strings
  def urls_from_text(text)
    text.split(',')
  end
end