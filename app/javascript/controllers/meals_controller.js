import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["favouriteMeals", "mealName", "mealNotes", "image", "edit", "mealId", "noMealDiv", "mealCard"]

  static get values() {
    return {editIcon: String, deleteIcon: String}
  }


  saveChanges( event) {
    if (event.currentTarget.id != "") {
      let meal = favourite_dishes[event.currentTarget.id - 1]
      meal["name"] = this.mealNameTarget.value
      meal["notes"] = this.mealNotesTarget.value
      meal["image"] = this.imageTarget.src
    } else {
      this.makeNewMeal()
      this.favouriteMealsTarget.classList.remove('d-none')
      this.noMealDivTarget.classList.add('d-none')
      let favourite_dish = {
        "id": favourite_dishes.length + 1,
        "name": this.mealNameTarget.value,
        "notes": this.mealNotesTarget.value,
        "image": this.imageTarget.src
      }
      favourite_dishes.push(favourite_dish)
      this.resetModal()
    }
  }

  editMeal(event) {
    let meal = favourite_dishes[event.currentTarget.id - 1]
    this.mealNameTarget.value = meal["name"]
    this.mealNotesTarget.value = meal["notes"]
    this.imageTarget.src = meal["image"]
    this.mealIdTarget.id = meal["id"]
    $("#exampleModal").modal("toggle")
  }

  deleteMeal() {
    let meal_id  = this.mealCardTarget.getAttribute('data-id')
    this.mealCardTarget.remove()
    if(favourite_dishes.length == 0) {
      this.noMealDivTarget.classList.remove('d-none')
    }
  }

  makeNewMeal() {
    let dish = `<li data-meals-target="mealCard" data-id="${favourite_dishes.length + 1}">
       <img class='main_img' src='${this.imageTarget.src}'>
      <div class='d-flex justify-content-between align-items-center w-100 ml_15'>
        <div class="text-left">
          <h4>${this.mealNameTarget.value}</h4>
          <p>${this.mealNotesTarget.value.substring(0, 10).trim()}...</p>
        </div>
        <span class="cursor-pointer">
            <span id="${favourite_dishes.length + 1}" data-action="click->meals#editMeal">
                <img src="${this.editIconValue}">
            </span>
            <span>
            <img id="${favourite_dishes.length + 1}" data-action="click->meals#deleteMeal" src="${this.deleteIconValue}">
            </span> 
        </span>
      </div>
    </li>`
    this.favouriteMealsTarget.innerHTML = this.favouriteMealsTarget.innerHTML + dish
  }

  resetModal() {
    this.imageTarget.src = ""
    this.mealNameTarget.value = ""
    this.mealNotesTarget.value = ""
  }

  arrayRemove(mealId) {
    return favourite_dishes.filter(function(ele){
      return ele.id != mealId
    });
  }
}

