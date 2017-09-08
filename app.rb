$: << File.absolute_path(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra'
require 'text_handler'

# This class does nothing but estable the routes that hand off to TextHandler,
# which actually interfaces with the libs 
class RubyTextServer < Sinatra::Base
  post '/' do
    TextHandler.new.body_from_request(request)
  end
end