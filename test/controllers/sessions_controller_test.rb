require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create,  {provider: "github"}
  end

  test "Can Create a user" do
    assert_difference('User.count', 1) do
      login_a_user
      assert_response :redirect
      assert_redirected_to index_path
    end
  end

  test "If a user logs in twice, it doesn't create a second user" do
    login_a_user
    assert_no_difference('User.count') do
      login_a_user
      assert_response :redirect
      assert_redirected_to index_path
    end
  end

  test "If a user logs out, their session is destroyed" do
    login_a_user
    get :destroy
    assert session[:user] == nil
    assert_response :redirect
    assert_redirected_to sessions_index_path
  end

end
