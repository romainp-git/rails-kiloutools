import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-profil"
export default class extends Controller {
  static targets= ["form"]
  display(event) {
    event.preventDefault()

    const form = event.target.closest('[data-toggle-target="form"]')
    form.querySelector('.old-value').classList.toggle('d-none');
    form.querySelector('.new-value').classList.toggle('d-none');

  }
}
