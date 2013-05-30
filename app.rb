require 'rubygems'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'
require "sinatra/config_file"
require 'json'
require 'pony'
require 'mail'
require 'resolv'

config_file 'config.yml'

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
      email_notification(settings.email[:from], "subscribe: #{email}", "#{email} wants to subscribe to our mailing list.")
      return { :email => "#{email}" }.to_json
    else
      error 400, { :errors => ["#{email} is not a valid email"] }.to_json
    end
  rescue => e
    error 500, e.message.to_json
  end
end

# REQUEST BODY:
# {
#   "email" : "john.doe@xample.com",
#   "name" : "John Doe",
#   "message" : "super interesting message goes here"
# }
#
# RETURNS:
#   200 if all is well
#   400 with message(s) if not
#   500 if something unexpected goes wrong
#
post '/contact-us' do
  content_type :json

  begin
    json = JSON.parse(request.body.read)
    email = json['email']
    name = json['name']
    message = json['message']


    if valid_email?(email)
      # send emails and or save the email to a database
      puts email
      email_notification(settings.email[:from], "contact-us: #{email}", "#{message}")
      return { :email => "#{email}" }.to_json
    else
      error 400, { :errors => ["#{email} is not a valid email"] }.to_json
    end
  rescue => e
    error 500, e.message.to_json
  end
end

# post '/contact-us' do
#   json_data = JSON.parse(request.body.read)
#   # data.to_json
#  # "#name: {params[:name]}"
#   # "contact-us"
#   redirect "http://localhost:4000"
# end

# for testing only
get '/contact-bosco' do
  "Bosco"
end

# this is set up to send through google.
# see Pony documentation for other options
def email_notification(from_email, subject, body='')
  Pony.mail({
    :to => settings.email[:to],
    :subject => subject,
    :body => body,
    :via => :smtp,
    :via_options => {
      :address              => settings.smtp[:server],
      :port                 => settings.smtp[:port],
      :enable_starttls_auto => true,
      :user_name            => settings.smtp[:username],
      :password             => settings.smtp[:password],
      :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
      :domain               => settings.smtp[:domain] # the HELO domain provided by the client to the server
    }
  })
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

