require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  let(:valid_password)        { "ValidPassword1234!@#" }
  let(:min_length_password)   { "Ab1@Ab1@Ab1@" }
  let(:short_password)        { "Ab1@Ab1@Ab1" }
  let(:no_caps_password)      { "nocapspassword1234!@#" }
  let(:no_lowercase_password) { "NOLOWERCASE1234!@#" }
  let(:no_num_password)       { "NoNumberPassword!@#" }
  let(:no_sybmbol_password)   { "NoSymbolPassword1234" }
  let(:max_length_password)   { "Ab1@" * 18 }
  let(:too_long_password)      { "Ab1@" * 20 }

  def fill_in_password(password, password_confirmation=nil)
    password_confirmation ||= password
    fill_in "Password", with: password
    fill_in "Password Confirmation", with: password_confirmation
  end

  test "should create user" do
    visit root_url

    fill_in_password(valid_password)

    click_on "Create User"

    assert_text "User was successfully created"
    click_on "New User"
  end

  test "should validate password" do
    visit root_url
    button = find_button("Create User", disabled: true)
    assert button[:disabled] == "true"

    fill_in_password(valid_password)
    assert_not button[:disabled] == "true"

    fill_in_password(valid_password, "")
    assert button[:disabled] == "true"

    fill_in_password(min_length_password)
    assert_not button[:disabled] == "true"

    fill_in_password(short_password)
    assert button[:disabled] == "true"

    fill_in_password(no_caps_password)
    assert button[:disabled] == "true"

    fill_in_password(no_lowercase_password)
    assert button[:disabled] == "true"

    fill_in_password(no_num_password)
    assert button[:disabled] == "true"

    fill_in_password(no_sybmbol_password)
    assert button[:disabled] == "true"

    fill_in_password(max_length_password)
    assert_not button[:disabled] == "true"
  end
end
