import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets () {
    return ['password', 'toggleIcon']
  }

  togglePassword () {
    console.log('clicked')
    this.passwordTarget.setAttribute('type', this.passwordTarget.getAttribute('type') === 'password' ? 'text' : 'password')
    this.toggleIconTarget.classList.toggle('fa-eye')
    this.toggleIconTarget.classList.toggle('fa-eye-slash')
  }
}