# A class to retrieve text from urls
require 'net/http'
require 'concurrent'

class TextClient
  # Single entry point for client processing of text representing URLs and
  # returning the aggregate content at those URLs
  def retrieve(text)
    urls = urls_from_text(text)
    retrieve_text_from_urls(urls)
  end

  # @param [String] a comma-separated list of URLs
  # @return [Array] an array of URL strings
  def urls_from_text(text)
    text.split(',')
  end

  # Net::HTTP::get will return the plain text of the response body
  # @param [String] a URL to GET
  # @return [String] the string content at that URL
  def retrieve_text(url)
    # Net::HTTP is terribly broken w/rt encoding
    text = Net::HTTP.get(URI(url))
    # in case we get a nil response or something odd, only force encoding if
    # this is an object that will take it
    text.respond_to?(:force_encoding) ? text.force_encoding(Encoding::UTF_8) : text
  end

  def retrieve_text_from_urls(urls)
    # We use the agent implementation from concurrent-ruby, inspired by other
    # languages with built-in concurrency primitives. This is a type for shared
    # asynchronous mutable state, modifications to which will be interleaved
    # based on threads completing.
    agent = Concurrent::Agent.new("")
    urls.each do |url|
      agent.send { |contents| contents + retrieve_text(url) }
    end
    agent.await
    agent.value
  end
end