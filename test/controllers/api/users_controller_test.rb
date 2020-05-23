require 'test_helper'

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should not create user if params are empty" do
    user = User.new
    assert_not user.save
  end

  test "should register user" do
    post api_users_path, params: { user: {name: 'Jack', email: "jack@gmail.com", password: "jack123" }}
    assert_response :success
    assert_equal 'Jack', JSON.parse(response.body)["user"]["name"]
    assert_equal 'jack@gmail.com', JSON.parse(response.body)["user"]["email"]
    assert_equal 'jack123', JSON.parse(response.body)["user"]["password"]
  end

  test "should not register user with same email" do
    post api_users_path, params: { user: {name: 'Jack', email: "jack@gmail.com", password: "jack123" }}
    post api_users_path, params: { user: {name: 'Jack', email: "jack@gmail.com", password: "jack123" }}
    assert_equal response.message, "Unprocessable Entity"
  end

  test "should return user of specific id" do
    post api_users_path, params: { user: {name: 'Jack', email: "jack@gmail.com", password: "jack123" }}
    user_details = JSON.parse(response.body)
    get api_user_path user_details["user"]["id"]
    assert_equal user_details["user"]["email"], JSON.parse(response.body)["user"]["email"]
    assert_equal user_details["user"]["name"], JSON.parse(response.body)["user"]["name"]
  end

end