require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "Should receive session token after login" do
    User.create( name: 'Jack', email: "jack@gmail.com", password: "jack123" )
    post login_path, params: { user: { email: "jack@gmail.com", password: "jack123" }}
    assert JSON.parse(response.body)["auth_token"]
  end

  test "Should not receive session token if invalid username or password given for login" do
    User.create( name: 'Jack', email: "jack@gmail.com", password: "jack123" )
    post login_path, params: { user: { email: "john@gmail.com", password: "john123" }}
    assert_nil JSON.parse(response.body)["auth_token"]
    assert_equal "Invalid email or password", JSON.parse(response.body)["message"]
    assert_equal 404, JSON.parse(response.code)
  end

end