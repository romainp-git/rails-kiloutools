import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "badge"]

  connect() {
    console.log("Le contrôleur est connecté");
  }

  toggle() {
    const productId = this.checkboxTarget.dataset.productId;
    const isActive = this.checkboxTarget.checked;

    this.updateBadge(isActive);

    fetch(`/products/${productId}/update_active`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ active: isActive }),
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .catch(error => console.error("Error updating product status:", error));
  }

  updateBadge(isActive) {
    const badge = this.badgeTarget;

    if (isActive) {
      badge.classList.remove("bg-danger");
      badge.classList.add("bg-success");
      badge.textContent = "En ligne";
    } else {
      badge.classList.remove("bg-success");
      badge.classList.add("bg-danger");
      badge.textContent = "Hors ligne";
    }
  }
}
