import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["clearInput"]

  clearField() {
    const inputFields = this.clearInputTargets ;

    inputFields.forEach(inputField => {
      inputField.value = '';
    });
  }
}