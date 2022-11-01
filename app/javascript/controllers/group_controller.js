import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card-select"]
  static values = {search: String}

  search(event){
    let searchData =`search=${event.currentTarget.value}`
    this.request(searchData)
  }
  request(searchData) {
    let that = this
    $.ajax({
      type: "GET",
      url: this.searchValue,
      data: searchData,
      dataType: 'json',
      success(response) {
        console.log(response[0].search_reviews)
      }
    })
  }
  cardSelect(event){
    if(event.currentTarget.classList.contains("review-card-select")){
      event.currentTarget.classList.remove("review-card-select")
    }
    else{
      event.currentTarget.classList.add("review-card-select")
    }
  }
}