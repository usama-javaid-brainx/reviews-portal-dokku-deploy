import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainImage", "thumbnailSection", "jsUploadedFiles", "fileUploadPlace", 'imageUrl']

  clickImage(event) {
    this.mainImageTarget.src = event.currentTarget.src
  }

  deleteImage(event) {
    imagesUrl = imagesUrl.filter(element => element !== event.currentTarget.previousElementSibling.src);
    event.currentTarget.parentElement.remove()
    if (!this.hasThumbnailSectionTarget) {
      this.mainImageTarget.parentElement.remove()
      this.fileUploadPlaceTarget.classList.remove('d-none')
      this.jsUploadedFilesTarget.classList.add('d-none')
      const hiddenInput = document.createElement('input')
      const attributes = { type:"hidden", name: "review[images][]", value: null }
      hiddenInput.classList.add("image-inputs")
      Object.assign(hiddenInput, attributes)
      this.jsUploadedFilesTarget.appendChild(hiddenInput)
    }
  }

  sortImages(){
    let updatedImageArray = []
    this.thumbnailSectionTargets.forEach(function (imageWrapper) {
      updatedImageArray.push(imageWrapper.firstChild.src)
    })
    imagesUrl = updatedImageArray
    this.mainImageTarget.src = imagesUrl[0]
  }
}