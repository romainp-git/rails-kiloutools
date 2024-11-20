import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-profil"
export default class extends Controller {
  static targets= ["form"]
  display() {
    this.formTarget.classList.toggle("d-none")
  }
}
