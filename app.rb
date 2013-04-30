require 'rubygems'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'
require 'json'

get '/contact-bosco' do
  "Bosco"
end

post '/contact-bosco' do
  name = 'Bosco'
  "name: #{name}"
end

get '/contact-us' do
  'contacto'
end

post '/contact-us' do
  data = JSON.parse(request.body.read)
  # data.to_json
 # "#name: {params[:name]}"
  # "contact-us"
  redirect "http://localhost:4000"
end