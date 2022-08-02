import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["favouriteMeals", "mealName" ,"mealNotes", "image", "edit", "mealId", "noMealDiv", "mealCard", "modalLabel"]

  static get values() {
    return {editIcon: String, deleteIcon: String}
  }

  saveChanges(event) {
    if (event.currentTarget.id >= "1") {
      var favourite_dish = favourite_dishes[event.currentTarget.id - 1]
      favourite_dish["name"] = this.mealNameTarget.value
      favourite_dish["notes"] = this.mealNotesTarget.value
      favourite_dish["image"] = this.imageTarget.src
      event.currentTarget.id = ""
      this.updateCard(favourite_dish)
    } else {
      this.makeNewMeal()
      this.favouriteMealsTarget.classList.remove('d-none')
      this.noMealDivTarget.classList.add('d-none')
      var favourite_dish = {
        "id": favourite_dishes.length + 1,
        "name": this.mealNameTarget.value,
        "notes": this.mealNotesTarget.value,
        "image": this.imageTarget.src
      }
    }
    favourite_dishes.push(favourite_dish)
    this.resetModal()
  }
  updateCard(favDish){
    document.getElementById(`image-${favDish["id"]}`).src = favDish["image"]
    document.getElementById(`name-${favDish["id"]}`).innerText = favDish["name"]
    document.getElementById(`notes-${favDish["id"]}`).innerText = favDish["notes"]
  }

  editMeal(event) {
    this.modalLabelTarget.innerText = "Edit Meal"
    let meal = favourite_dishes[event.currentTarget.id - 1]
    this.mealNameTarget.value = meal["name"]
    this.mealNotesTarget.value = meal["notes"]
    this.imageTarget.src = meal["image"]
    this.mealIdTarget.id = meal["id"]
    $("#exampleModal").modal("toggle")
  }

  deleteMeal() {
    this.mealCardTarget.remove()
    if(!this.hasMealCardTarget) {
      this.noMealDivTarget.classList.remove('d-none')
    }
  }

  makeNewMeal() {
    let dish = `<li data-meals-target="mealCard" id="${favourite_dishes.length + 1}">
       <img id = "image-${favourite_dishes.length + 1}" class='main_img' src='${this.imageTarget.src}'>
      <div class='d-flex justify-content-between align-items-center w-100 ml_15'>
        <div class="text-left">
          <h4 id = "name-${favourite_dishes.length + 1}"> ${this.mealNameTarget.value}</h4>
          <p id = "notes-${favourite_dishes.length + 1}">${this.mealNotesTarget.value.substring(0, 20).trim()}...</p>
        </div>
        <span class="cursor-pointer">
            <span id="${favourite_dishes.length + 1}" data-action="click->meals#editMeal">
                <img src="${this.editIconValue}">
            </span>
            <span>
            <img style="background-color: red" id="${favourite_dishes.length + 1}" data-action="click->meals#deleteMeal" src="${this.deleteIconValue}">
            </span> 
        </span>
      </div>
    </li>`
    this.favouriteMealsTarget.innerHTML = this.favouriteMealsTarget.innerHTML + dish
  }

  resetModal(event) {
    this.modalLabelTarget.innerText = "Add Meal"
    this.imageTarget.src = ""
    this.mealNameTarget.value = ""
    this.mealNotesTarget.value = ""
  }
}

