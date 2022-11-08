import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["shareMsg", "urlField"]
  static values = {
    slug: String
  }

  connect() {
    // TODO: Logos are missing, didn't provided by client yet
    $("#share").jsSocials({
      shareIn: "popup",
      showLabel: true,
      shares: [{
        share: "email",
        logo: "",
        label: "Mail"
      }, {
        share: "twitter",
        logo: "",
        label: "Tweet"
      }, {
        share: "facebook",
        logo: "",
        label: "Facebook"
      }, {
        share: "googleplus",
        logo: "",
        label: "Google +"
      }, {
        share: "linkedin",
        logo: "",
        label: "LinkedIn"
      }, {
        share: "pinterest",
        logo: "",
        label: "Pinterest"
      }]
    });
  }

  addLinkField() {
    var copiedUrl = window.location.href
    this.urlFieldTarget.innerText = copiedUrl
  }

  copyLink() {
    navigator.clipboard.writeText(window.location.href)
    $(this.shareMsgTarget).toggleClass('d-none')
    setTimeout(
      () => {
        $(this.shareMsgTarget).toggleClass('d-none')
      }, 3000);
  }
}