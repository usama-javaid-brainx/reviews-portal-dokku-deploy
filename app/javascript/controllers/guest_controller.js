import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["shareMsg"]
  static values = {
    slug: String
  }

  copyLink() {
    navigator.clipboard.writeText(window.location.href)
    $(this.shareMsgTarget).toggleClass('d-none')
    setTimeout(
      () => {
        $(this.shareMsgTarget).toggleClass('d-none')
      }, 3000);
  }

  back() {
    let prev_url = document.referrer;
    if (prev_url.indexOf(window.location.origin) === -1) {
      window.location.assign(window.location.origin)
    } else {
      history.go(-1)
    }
  }
}