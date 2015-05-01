require 'test_helper'

class MyApiTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    MyApi
  end

  test "action3" do
    get "/api/action3"
    assert last_response.ok?
    # p last_response.body
  end

  test "action4" do
    get "/api/sub_ns/action4"
    assert last_response.ok?
  end

  test "action5" do
    put "/api/action5"
    assert last_response.ok?
  end

  test "action6" do
    delete "/api/action6"
    assert last_response.ok?
  end
end
