require 'sinatra'

get '/' do
  "Hey it's Sinatra! The time on the server is #{Time.now}"
end

get '/about' do
  "About section"
end


get '/help' do
  "<h1>Help Section</h1>"
end

get '/random' do
  "The number is #{rand(1..7)}"
end
