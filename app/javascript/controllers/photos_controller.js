import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainImage", "thumbnailSection"]

  clickImage(event) {
    this.mainImageTarget.src = event.currentTarget.src
  }

  deleteImage(event) {
    event.currentTarget.parentElement.remove()
    if(!this.hasThumbnailSectionTarget){
      document.getElementById('file-upload-place').classList.remove('d-none')
      document.getElementById('js-uploaded-files').classList.add('d-none')
    }
  }
}