import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["summary", "form", "product", "city", "startDate", "endDate",
                    "productInput", "cityInput", "startDateInput", "endDateInput"];

  connect() {
    this.collapse();
    document.addEventListener("click", this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
  }

  expand() {
    this.element.classList.add("expanded");
    this.summaryTarget.classList.add("d-none");
    this.formTarget.classList.remove("d-none");
  }

  collapse() {
    this.productTarget.innerText = this.productInputTarget.value != "" ? this.productInputTarget.value : "Tous";
    this.cityTarget.innerText = this.cityInputTarget.value != "" ? this.cityInputTarget.value : "Partout";
    this.startDateTarget.innerText = this.startDateInputTarget.value;
    this.endDateTarget.innerText = this.endDateInputTarget.value;

    this.element.classList.remove("expanded");
    this.formTarget.classList.add("d-none");
    this.summaryTarget.classList.remove("d-none");
  }

  handleClickOutside(event) {
    if (event.target.closest(".autocomplete-list")) {
      return;
    }

    if (!this.element.contains(event.target)) {
      this.collapse();
    }
  }
}
