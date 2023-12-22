class User < ApplicationRecord
  PASSWORD_VALIDATIONS = {
    contains_lowercase:         /[a-z]+/,
    contains_uppercase:         /[A-Z]+/,
    contains_digit:             /\d+/,
    contains_special_character: /[^\w\d]+/
  }
  has_secure_password
  validates :password, length: { minimum: 12 , message: I18n.t("activerecord.errors.models.user.attributes.password.length")}, allow_blank: true
  validate :validate_password_requirements, if: -> { password.present? }

  def validate_password_requirements
    PASSWORD_VALIDATIONS.each do |type, regex|
      errors.add(:password, I18n.t("activerecord.errors.models.user.attributes.password.#{type}")) unless password.match(regex)
    end
  end
end
