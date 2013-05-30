require_relative '../app.rb'

require 'test/unit'
require 'rack/test'
require 'json'

class ContactUsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_subscribe_good_emails
    emails = %w(jimboni@xxx.com boboin@gmail.com justin@time.mx jim+01@gmail.com)
    emails.each do |email|
      post '/subscribe', { :email => email }.to_json
      assert last_response.ok?
      json = JSON.parse(last_response.body)
      assert_equal email, json['email']
    end
  end

  def test_subscribe_bad_emails
    emails = %w(jimboni@com boboingmail.com time.mx jim+01@@gmail.com)
    emails.each do |email|
      post '/subscribe', { :email => email }.to_json
      assert_equal last_response.status, 400
    end
  end

end
