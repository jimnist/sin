require 'rubygems'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'
require 'json'
require 'mail'
require 'resolv'

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

# post '/contact-us' do
#   json_data = JSON.parse(request.body.read)
#   # data.to_json
#  # "#name: {params[:name]}"
#   # "contact-us"
#   redirect "http://localhost:4000"
# end

# REQUEST BODY:
# {
#   "email" : "john.doe@xample.com"
# }
#
# RETURNS:
#   200 if all is well
#   400 with message(s) if not
#   500 if something unexpected goes wrong
#
post '/subscribe' do
  content_type :json

  begin
    json = JSON.parse(request.body.read)
    email = json['email']

    if valid_email?(email)
      # send emails and or save the email to a database
      return { :email => "#{email}" }.to_json
    else
      error 400, { :errors => ["#{email} is not a valid email"] }.to_json
    end
  rescue => e
    error 500, e.message.to_json
  end
end

def valid_email?(email)
  reggie = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  if email =~ reggie
    domain = email.match(/\@(.+)/)[1]
    Resolv::DNS.open do |dns|
      @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
    end
    @mx.size > 0 ? true : false
  else
    false
  end
end
