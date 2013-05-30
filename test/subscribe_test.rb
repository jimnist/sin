require_relative '../app.rb'

require 'test/unit'
require 'rack/test'

class ContactUsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_subscribe_good_email
    w%(jimboni@xxx.com boboin@gmail.com justin@time.mx).each do email
      post '/subscribe', :email => email
      assert_equal 'email: ', last_response.body
    end
  end

  # def test_contact_us
  #   post '/contact-us', :name => 'Bosco'
  #   assert_equal 'name: Bosco', last_response.body
  # end
end
