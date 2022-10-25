import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["shareMsg"]
  static values = {
    slug: String
  }

  copyLink() {
    var copy =  navigator.clipboard.writeText(window.location.href)
    $(this.shareMsgTarget).toggleClass('d-none')
    setTimeout(
      ()=> {
        $(this.shareMsgTarget).toggleClass('d-none')
      }, 3000);
  }
}