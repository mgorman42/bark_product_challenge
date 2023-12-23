require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  let(:valid_password) { "ValidPassword1234!@#" }

  test "should create user" do
    visit root_url

    fill_in "Password", with: valid_password
    fill_in "Password Confirmation", with: valid_password

    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end
end
