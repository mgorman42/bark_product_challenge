require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  let(:valid_password) { "ValidPassword1234!@#" }
  
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { password: valid_password, password_confirmation: valid_password  } }
    end
    new_user = User.last

    assert_redirected_to user_url(new_user)

    assert new_user.authenticate(valid_password)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end
end
