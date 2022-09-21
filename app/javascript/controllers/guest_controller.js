import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["shareMsg"]
  static values = {
    slug: String
  }

  copyLink() {
    let url = window.location.origin
    let parsedUrl = window.location.href.split('/')
    navigator.clipboard.writeText(`${url}/guests/show?slug=${this.slugValue}`)
    $(this.shareMsgTarget).toggleClass('d-none')
    setTimeout(
      ()=> {
        $(this.shareMsgTarget).toggleClass('d-none')
      }, 3000);
  }
}