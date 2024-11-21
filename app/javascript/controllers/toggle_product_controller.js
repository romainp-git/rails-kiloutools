import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  connect() {

    console.log("Le contrôleur est connecté");
  }

  toggle() {
    const productId = this.checkboxTarget.dataset.productId;
    const isActive = this.checkboxTarget.checked;

    fetch(`/products/${productId}/update_active`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ active: isActive })
    })
    .then(response => response.json())

  }
}
