require 'rubygems'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'
require 'json'
require 'mail'

before do
  content_type :json
end

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
  begin
    # data = request.body.read
    json = JSON.parse(request.body.read)
    email = json['email']

    if email_valid?(email)
      # send emails and or save the email to a database
      return email
    else
      error 400, "#{email} is not a valid email"
    end
  rescue => e
    error 500, e.message.to_json
  end
end

# based on http://my.rails-royce.org/2010/07/21/email-validation-in-ruby-on-rails-without-regexp/
def email_valid?(email)
  begin
    m = Mail::Address.new(email)
    r = m.domain && m.address == value
    t = m.__send__(:tree)
    # We need to dig into treetop
    # A valid domain must have dot_atom_text elements size > 1
    # user@localhost is excluded
    # treetop must respond to domain
    # We exclude valid email values like <user@localhost.com>
    # Hence we use m.__send__(tree).domain
    r &&= (t.domain.dot_atom_text.elements.size > 1)
    true
  rescue => e
    false
  end
end
