import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["favouriteMeals", "mealName", "mealNotes", "image", "edit", "mealId", "noMealDiv", "mealCard", "modalLabel"]

  static get values() {
    return {editIcon: String, deleteIcon: String}
  }

  connect() {
    super.connect();
    this.favourite_dishes = [];
  }

  saveChanges(event) {
    if (event.currentTarget.id !== "") {
      let favourite_dish = {id: event.currentTarget.id}
      favourite_dish["name"] = this.mealNameTarget.value
      favourite_dish["notes"] = this.mealNotesTarget.value
      favourite_dish["image"] = this.imageTarget.getAttribute('src')
      event.currentTarget.id = ""
      this.updateCard(favourite_dish)
    } else {
      this.makeNewMeal()
      this.favouriteMealsTarget.classList.remove('d-none')
      this.noMealDivTarget.classList.add('d-none')
      var favourite_dish = {
        "id": this.favourite_dishes.length + 1,
        "name": this.mealNameTarget.value,
        "notes": this.mealNotesTarget.value,
        "image": this.imageTarget.src
      }
    }
    this.favourite_dishes.push(favourite_dish)
    this.resetModal()
  }

  updateCard(favDish) {
    let id = favDish["id"]
    document.getElementById(`image-${id}`).src = favDish["image"]
    document.getElementById(`review_meals_attributes_${id}_image_url`).value = favDish["image"]
    document.getElementById(`name-${id}`).innerText = favDish["name"]
    document.getElementById(`review_meals_attributes_${id}_name`).value = favDish["name"]
    document.getElementById(`notes-${id}`).innerText = favDish["notes"]
    document.getElementById(`review_meals_attributes_${id}_notes`).value = favDish["notes"]
  }

  editMeal(event) {
    let id = event.currentTarget.id
    this.modalLabelTarget.innerText = "Edit Meal"
    this.mealNameTarget.value = document.getElementById(`review_meals_attributes_${id}_name`).value
    this.mealNotesTarget.value = document.getElementById(`review_meals_attributes_${id}_notes`).value
    this.imageTarget.src = document.getElementById(`review_meals_attributes_${id}_image_url`).value
    this.mealIdTarget.id = id
    $("#exampleModal").modal("toggle")
  }

  deleteMeal(event) {

    document.getElementById(event.currentTarget.id).remove()
    if (!this.hasMealCardTarget) {
      this.noMealDivTarget.classList.remove('d-none')
    }
  }


  // deleteMeal(event) {
  //   let currentMeal = document.getElementById(event.currentTarget.id)
  //
  //   $.ajax({
  //     type: "GET",
  //     url: document.getElementById(event.currentTarget.id).getAttribute('data-url'),
  //     data: `meal_id=${document.getElementById(event.currentTarget.id).getAttribute('data-value')}`,
  //     dataType: 'json',
  //     success(){
  //       currentMeal.remove()
  //     }
  //   })
  //
  //   if (!this.hasMealCardTarget) {
  //     this.noMealDivTarget.classList.remove('d-none')
  //   }
  // }


  makeNewMeal() {
    let randomId = Math.floor(Math.random() * 1000) * 3243;
    let imgSrc = ""
    if (this.imageTarget.getAttribute('src')) {
      imgSrc = this.imageTarget.src

    }
    let dish = `<li data-meals-target="mealCard" id="${randomId}">
       <img id = "image-${randomId}" class='main_img' src='${imgSrc}'>
       <input name="review[meals_attributes][${randomId}][image_url]" value="${imgSrc}" hidden id = "review_meals_attributes_${randomId}_image_url">
       <input name="review[meals_attributes][${randomId}][name]" value="${this.mealNameTarget.value}" hidden id = "review_meals_attributes_${randomId}_name">
       <input name="review[meals_attributes][${randomId}][notes]" value="${this.mealNotesTarget.value}" hidden id = "review_meals_attributes_${randomId}_notes">
      <div class='d-flex justify-content-between align-items-center w-100 ml_15'>
        <div class="text-left">
          <h4 id="name-${randomId}"> ${this.mealNameTarget.value}</h4>
          <p id="notes-${randomId}">${this.mealNotesTarget.value.substring(0, 20).trim()}...</p>
        </div>
        <span class="cursor-pointer">
            <span id="${randomId}" data-action="click->meals#editMeal">
                <img src="${this.editIconValue}">
            </span>
            <span>
            <img style="height: 17px" id="${randomId}" data-action="click->meals#deleteMeal" src="${this.deleteIconValue}">
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

