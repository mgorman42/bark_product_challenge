import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['password', 'passwordConfirmation', 'validations', 'passwordConfirmationMessage', 'submit']

  validatePassword() {
    this.enableSubmit();
    this.validationsTargets.forEach(this.validatePasswordElement.bind(this));
  }

  validatePasswordElement(element) {
    let validationType = element.getAttribute("validation-type");
    let validationValue = element.getAttribute("validation-value");
    switch(validationType) {
      case "length":
        this.validatePasswordMinLength(element, validationValue);
        break;
      case "regex":
	this.validatePasswordRegex(element, validationValue);
        break;
    }
    this.validatePasswordMatch();
  }

  validatePasswordMinLength(element, length) {
    length = parseInt(length);
    let password = this.passwordTarget.value;
    if (password.length < length) {
      element.classList.remove("pass_password_validation");
      this.disableSubmit();
    } else {
      element.classList.add("pass_password_validation");
      element.classList.remove("fail_password_validation");
    }
  }

  validatePasswordRegex(element, regexString) {
    let regexArray = regexString.split("/")
    let regex = new RegExp(regexArray[1], regexArray[2])
    let password = this.passwordTarget.value;
    if (password.match(regex)) {
      element.classList.add("pass_password_validation");
      element.classList.remove("fail_password_validation");
    } else {
      element.classList.remove("pass_password_validation");
      this.disableSubmit();
    }
  }

  validatePasswordMatch() {
    let password = this.passwordTarget.value;
    let passwordConfirmation = this.passwordConfirmationTarget.value;
    if (passwordConfirmation && password == passwordConfirmation) {
      this.passwordConfirmationMessageTarget.classList.add("pass_password_validation");
      this.passwordConfirmationMessageTarget.classList.remove("fail_password_validation");
    } else {
      this.passwordConfirmationMessageTarget.classList.remove("pass_password_validation");
      this.disableSubmit();
    }
  }

  enableSubmit() {
    this.submitTarget.disabled=false
  }

  disableSubmit() {
    this.submitTarget.disabled=true
  }
}
