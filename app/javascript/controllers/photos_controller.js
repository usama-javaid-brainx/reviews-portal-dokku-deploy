import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainImage", "notification", "thumbnailSection", "jsUploadedFiles", "fileUploadPlace", 'imageUrl']

  static values = {
    imageUploadUrl: String,
    reviewId: String
  }

  clickImage(event) {
    this.mainImageTarget.src = event.currentTarget.src
  }

  connect() {
    if (this.hasThumbnailSectionTarget) {
      this.mainImageTarget.src = this.thumbnailSectionTarget.firstElementChild.src
      this.sortImages()
    }
  }

  deleteImage(event) {
    imagesUrl = imagesUrl.filter(element => element !== event.currentTarget.previousElementSibling.src);
    event.currentTarget.parentElement.remove()
    if (!this.hasThumbnailSectionTarget) {
      this.mainImageTarget.parentElement.remove()
      this.fileUploadPlaceTarget.classList.remove('d-none')
      this.jsUploadedFilesTarget.classList.add('d-none')
      const hiddenInput = document.createElement('input')
      const attributes = {type: "hidden", name: "review[images][]", value: null}
      hiddenInput.classList.add("image-inputs")
      Object.assign(hiddenInput, attributes)
      this.jsUploadedFilesTarget.appendChild(hiddenInput)
    }
  }

  mainThumbnailDelete(){
    event.currentTarget.previousElementSibling.src = null
  }

  sortImages() {
    imagesUrl = []
    this.thumbnailSectionTargets.forEach(function (imageWrapper) {
      imagesUrl.push(imageWrapper.firstElementChild.src)
    })
    this.mainImageTarget.src = imagesUrl[0]
  }

  saveImages() {
    let that = this
    $.ajax({
      type: "GET",
      url: this.imageUploadUrlValue,
      data: {
        review_id: this.reviewIdValue,
        images_url: imagesUrl
      },
      success(response) {
        that.notificationTarget.classList.remove("d-none")
        setTimeout(function(){
          window.close();
        }, 5000);
      }
    })
  }
}