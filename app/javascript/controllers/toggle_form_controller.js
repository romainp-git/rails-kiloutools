import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["summary", "form"];

  connect() {
    console.log("hello");
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
    this.element.classList.remove("expanded");
    this.formTarget.classList.add("d-none");
    this.summaryTarget.classList.remove("d-none");
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.collapse();
    }
  }
}
