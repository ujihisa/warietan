require 'sinatra'

REVISION = `git rev-parse --verify HEAD`.chomp

get '/' do
  "OK #{REVISION.inspect}"
end

post '/' do
  # Implement warietan deployment
end
