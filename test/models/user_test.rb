require "test_helper"

class UserTest < ActiveSupport::TestCase
  let(:user) { User.new }

  describe 'password' do
    let(:password_base)         { "Ab1@" }
    let(:minimum_length)        { 12 }
    let(:valid_password)        { generate_password(password_base, minimum_length + 5) }
    let(:min_length_password)   { generate_password(password_base, minimum_length) }
    let(:short_password)        { generate_password(password_base, minimum_length - 1)}
    let(:no_caps_password)      { generate_password("b1@", minimum_length + 5) }
    let(:no_lowercase_password) { generate_password("A1@", minimum_length + 5) }
    let(:no_num_password)       { generate_password("Ab@", minimum_length + 5) }
    let(:no_sybmbol_password)   { generate_password("Ab1", minimum_length + 5) }
    let(:max_length_password)   { generate_password(password_base, 72) }
    let(:too_long_password)     { generate_password(password_base, 73) }

    def generate_password(base, length)
      repeat_count = length / base.length
      extra = length % base.length
      base * repeat_count + base.slice(0, extra)
    end

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
