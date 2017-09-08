# A class to retrieve text from urls
require 'net/http'

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
    Net::HTTP.get(URI(url))
  end

  # We can parallelize the retrieval from multiple URLs and aggregate the response using pipes
  def retrieve_text_from_urls(urls)
    reader, writer = IO.pipe
    begin
      urls.each do |url|
        Thread.new do
          text = retrieve_text(url)
          writer.write(text)
        end.join
      end
    ensure
      writer.close
    end
    aggregate_content = reader.read
    reader.close
    aggregate_content
  end
end