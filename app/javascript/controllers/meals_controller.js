import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["favouriteMeals", "mealName", "mealNotes", "fileInput", "image",]

  static get values() {
    return {editIcon: String, deleteIcon: String}
  }

  connect() {
    super.connect()
    let that = this
    $('#imageSelected').bind('change', function (event) {
      that.imageSelected(event)
    })
  }


  saveChanges() {
    this.showUploadedMeal()
    this.favouriteMealsTarget.classList.remove('d-none')

    let favourite_dish = {
      "id": favourite_dishes.length + 1,
      "name": this.mealNameTarget.value,
      "notes": this.mealNotesTarget.value,
      "image": this.imageTarget.src
    }
    favourite_dishes.push(favourite_dish)
    this.refreshModal()
  }

  showUploadedMeal() {
    let dish = `<li id="${favourite_dishes.length + 1}"><img class='main_img' src='${this.imageTarget.src}'>
      <div class='d-flex justify-content-between align-items-center w-100 ml_15'>
        <div class="text-left">
          <h4>${this.mealNameTarget.value}</h4>
          <p>${this.mealNotesTarget.value.substring(0, 10).trim()}...</p>
        </div>
        <span class="cursor-pointer">
            <span><img src="${this.editIconValue}"></span>
            <span><img src="${this.deleteIconValue}"></span> 
        </span>
      </div>
    </li>`
    this.favouriteMealsTarget.innerHTML = this.favouriteMealsTarget.innerHTML + dish
  }

  refreshModal() {
    this.imageTarget.src = ""
    this.mealNameTarget.value = ""
    this.mealNotesTarget.value = ""
  }

  openFileSelector() {
    this.fileInputTarget.click()
  }

  imageSelected(event) {
    let that = this
    let file = $(event.target)[0].files[0]
    let reader = new FileReader()
    reader.onload = function (e) {
      that.imageTarget.src = e.target.result
    }
    reader.readAsDataURL(file)
  }

}