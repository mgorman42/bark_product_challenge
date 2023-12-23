require "test_helper"

class UserTest < ActiveSupport::TestCase
  let(:user) { User.new }

  describe 'password' do
    let(:valid_password)        { "ValidPassword1234!@#" }
    let(:min_length_password)   { "Ab1@Ab1@Ab1@" }
    let(:short_password)        { "Ab1@Ab1@Ab1" }
    let(:no_caps_password)      { "nocapspassword1234!@#" }
    let(:no_lowercase_password) { "NOLOWERCASE1234!@#" }
    let(:no_num_password)       { "NoNumberPassword!@#" }
    let(:no_sybmbol_password)   { "NoSymbolPassword1234" }
    let(:max_length_password)   { "Ab1@" * 18 }
    let(:too_long_password)     { "Ab1@" * 20 }

    def set_password(password, password_confirmation)
      user.password = password
      user.password_confirmation = password_confirmation
      user
    end

    def assert_password_valid(password)
      set_password(password, password)
      assert user.valid?
    end

    def assert_password_invalid(password, error_message, password_confirmation=nil)
      password_confirmation ||= password
      set_password(password, password_confirmation)
      assert_not user.valid?
      assert_includes  user.errors.messages.values.flatten, error_message
    end

    it 'validates password' do
      assert_password_invalid(nil, "Please enter a password.")
      assert_password_valid(valid_password)
      assert_password_valid(min_length_password)
      assert_password_valid(max_length_password)
      assert_password_invalid(valid_password, "Password and Confirmation must match", "")
      assert_password_invalid(valid_password, "Password and Confirmation must match", valid_password.reverse )
      assert_password_invalid(short_password, "Must be atleast 12 characters long")
      assert_password_invalid(no_lowercase_password, "Must contain a lowercase letter")
      assert_password_invalid(no_caps_password, "Must contain an uppercase letter")
      assert_password_invalid(no_num_password, "Must contain a number")
      assert_password_invalid(no_sybmbol_password, "Must contain a special character")
      assert_password_invalid(too_long_password, "Can't be more than 72 characters long")
    end
  end
end
