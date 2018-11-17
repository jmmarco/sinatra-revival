require 'sinatra'

get '/' do
  erb :home
end

get '/about' do
  "About section"
end

get '/greet/:name' do
  "Hello #{params[:name]}, long time no see!"
end


get '/help' do
  "<h1>Help Section</h1>"
end

get '/random' do
  "The number is #{rand(1..7)}"
end

get '/square/:number' do
  num = params[:number]

  "Yaasss #{num.to_i ** 2}"
end

get '/welcome' do
  "<h3>Welcome to <a href='http://sinatrarb.com/'>Sinatra</a>!</h3>"
end
