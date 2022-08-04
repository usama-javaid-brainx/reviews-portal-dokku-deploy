import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tagInput", "tags", "selectedTags"]

  makeTag(event) {
    let input_val = this.tagInputTarget.value.trim();
    let no_comma_val = input_val.replace(/,/g, "");
    // if ((input_val.slice(-1) === "," && no_comma_val.length > 0) || event.key === "Enter" && no_comma_val.length > 0) {
    if ((input_val.slice(-1) === "," || event.key === "Enter") && no_comma_val.length > 0) {
      var new_tag = compile_tag(no_comma_val);
      this.tagsTarget.appendChild(new_tag);
      this.selectedTagsTarget.value = this.selectedTagsTarget.value.concat(",", no_comma_val);
      this.tagInputTarget.value = "";
    }
  }
}

function compile_tag(tag_content) {
  let tag = document.createElement("div");
  tag.setAttribute("class", "tag-badge d-flex align-items-center mt-4 mr-2");
  let text = document.createElement("span");
  text.innerHTML = tag_content;

  let remove = document.createElement("i");
  remove.setAttribute("class", "fa fa-remove ml_10 mt-1");
  remove.setAttribute("id", "remove1");
  remove.onclick = function () {
    this.parentNode.remove();
  };

  tag.appendChild(text);
  tag.appendChild(remove);
  return tag;
}