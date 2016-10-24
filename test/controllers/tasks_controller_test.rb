require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  test "If a user is not logged in, they cannot see their task." do
    session[:user_id] = nil  # ensure no one is logged in
    get :show, id: tasks(:wash_dog).id
    # if they are not logged in they cannot see the resource and are redirected to login.
    assert_redirected_to sessions_index_path
    assert_equal "Please log in first!", flash[:notice]
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  #
  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end
  #
  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end
  #
  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end
  #
  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

end
