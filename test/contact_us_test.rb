require_relative '../app.rb'

require 'test/unit'
require 'rack/test'

class ContactUsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  # def test_bosco
  #   post '/contact-bosco', :name => 'Bosco'
  #   assert_equal 'name: Bosco', last_response.body
  # end

  # def test_contact_us
  #   post '/contact-us', :name => 'Bosco'
  #   assert_equal 'name: Bosco', last_response.body
  # end
end
