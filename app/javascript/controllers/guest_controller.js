import {Controller} from "@hotwired/stimulus"

export default class extends Controller {

  copyLink() {
    let url = window.location.origin
    let parsedUrl = window.location.href.split('/')
    let reviewNo = parsedUrl[parsedUrl.length -1 ]
    navigator.clipboard.writeText(url+'/guests/show?id='+reviewNo)
  }
}