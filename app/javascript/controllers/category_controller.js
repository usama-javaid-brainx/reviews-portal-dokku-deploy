import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category"]

  connect() {
    $("#category_id").select2()
    $("#review_category_id").select2()
    $("#category-id-mobile").select2()
    $("#review_to_try").select2({
      minimumResultsForSearch: Infinity
    });
    $(this.categoryTarget).on('select2:select select2:unselect', this.categorySelect.bind(this))
    $(document).on('turbo:before-cache', function () {
      $("#category_id").select2('destroy');
    });
  }

  categorySelect() {
    if (this.categoryTarget.value == "all") {
      window.location.href = `${window.location.href.split('?')[0]}?category_id=all`
    } else {
      window.location.href = `${window.location.href.split('?')[0]}?category_id=${this.categoryTarget.value}`
    }
  }

}