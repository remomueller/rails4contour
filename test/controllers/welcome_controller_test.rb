require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  setup do
    login(users(:valid))
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
