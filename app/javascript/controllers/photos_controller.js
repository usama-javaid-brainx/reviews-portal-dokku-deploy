import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mainImage"]

  clickImage(event) {
    this.mainImageTarget.src = event.currentTarget.src
  }

  deleteImage(event) {
    let deletedImage = event.currentTarget.previousElementSibling.src
    let inputs = document.getElementsByClassName("image-inputs")
    for(let i = 0; inputs.length > i; i++){
      if(inputs[i].value == deletedImage){
        event.currentTarget.previousElementSibling.remove()
        inputs[1].remove()
      }
    }
  }
}