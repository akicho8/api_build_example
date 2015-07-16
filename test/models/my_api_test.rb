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

  test "hello" do
    get "/api/sub/hello"
    assert last_response.ok?
  end

  test "put_action" do
    put "/api/put_action"
    assert last_response.ok?
  end

  test "delete_action" do
    delete "/api/delete_action"
    assert last_response.ok?
  end
end
