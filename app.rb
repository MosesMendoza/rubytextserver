$: << File.absolute_path(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra'
require 'ruby_textserver'

post '/' do
  RubyTextserver.body_from_request(request)
end
