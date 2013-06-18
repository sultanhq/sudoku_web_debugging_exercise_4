require 'rubygems'

# If you're using bundler, you will need to add this
# require 'bundler/setup'

require 'sinatra'

get '/' do
  "Hello world and James, it's #{Time.now} at the server!"
end

get '/dario' do
  "this is a new page"
end

get '/charlotte' do
  "Hi lady"
end
