require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  let(:password_base)         { "Ab1@" }
  let(:minimum_length)        { 12 }
  let(:valid_password)        { generate_password(password_base, minimum_length + 5) }
  let(:min_length_password)   { generate_password(password_base, minimum_length) }
  let(:short_password)        { generate_password(password_base, minimum_length - 1)}
  let(:no_caps_password)      { generate_password("b1@", minimum_length + 5) }
  let(:no_lowercase_password) { generate_password("A1@", minimum_length + 5) }
  let(:no_num_password)       { generate_password("Ab@", minimum_length + 5) }
  let(:no_sybmbol_password)   { generate_password("Ab1", minimum_length + 5) }

  def generate_password(base, length)
    repeat_count = length / base.length
    extra = length % base.length
    base * repeat_count + base.slice(0, extra)
  end

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
  end
end
