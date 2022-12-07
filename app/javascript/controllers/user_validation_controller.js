import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "inputValue", 'avatarUpload']

  connect() {
    this.formatNumber()
  }

  uploadImg() {
    this.avatarUploadTarget.click()
  }

  formatNumber() {
    let input = this.inputValueTarget.value
      let cleaned = ('' + input).replace(/\D/g, '');
      let match = cleaned.match(/^(1|)?(\d{3})(\d{3})(\d{4})$/);
      if (match) {
        let intlCode = (match[1] ? '+1 ' : '')
        event.currentTarget.value =  [intlCode, '(', match[2], ') ', match[3], '-', match[4]].join('')
        console.log([intlCode, '(', match[2], ') ', match[3], '-', match[4]].join(''))
      }
    }

}