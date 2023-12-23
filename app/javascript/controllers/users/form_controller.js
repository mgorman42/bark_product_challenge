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
        this.validatePasswordMinLength(element, parseInt(validationValue));
        break;
      case "regex":
	this.validatePasswordRegex(element, validationValue.replaceAll("/",""));
        break;
    }
    this.validatePasswordMatch();
  }

  validatePasswordMinLength(element, length) {
    let password = this.passwordTarget.value;
    if (password.length < length) {
      element.classList.remove("pass_password_validation");
      this.disableSubmit();
    } else {
      element.classList.add("pass_password_validation");
      element.classList.remove("fail_password_validation");
    }
  }

  validatePasswordRegex(element, regex) {
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
    if (password == passwordConfirmation) {
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
