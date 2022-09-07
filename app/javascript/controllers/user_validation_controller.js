import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ['avatarUpload']
  }

  uploadImg() {
    this.avatarUploadTarget.click()
  }
}