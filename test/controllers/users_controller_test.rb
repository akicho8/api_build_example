require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "action1" do
    get :action1, :format => "json"
    assert_response :success
  end

  test "action2" do
    get :action2, :format => "json"
    assert_response :success
  end
end
