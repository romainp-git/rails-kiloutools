import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["summary", "form", "product", "city", "startDate", "endDate",
                    "productInput", "cityInput", "startDateInput", "endDateInput"];

  connect() {
    document.addEventListener("click", this.handleClickOutside.bind(this));
    document.addEventListener("click", this.preventDisabledButtonAction);

    this.collapse();
    this.updateButtonState();
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
    document.removeEventListener("click", this.preventDisabledButtonAction);
  }

  expand() {
    this.element.classList.add("expanded");
    this.summaryTarget.classList.add("d-none");
    this.formTarget.classList.remove("d-none");

    this.updateButtonState();
  }

  collapse() {
    this.productTarget.innerText = this.productInputTarget.value != "" ? this.productInputTarget.value : "Tous";
    this.cityTarget.innerText = this.cityInputTarget.value != "" ? this.cityInputTarget.value : "Partout";
    this.startDateTarget.innerText = this.startDateInputTarget.value;
    this.endDateTarget.innerText = this.endDateInputTarget.value;

    this.element.classList.remove("expanded");
    this.formTarget.classList.add("d-none");
    this.summaryTarget.classList.remove("d-none");

    this.updateButtonState();
  }

  handleClickOutside(event) {
    if (event.target.closest(".autocomplete-list")) {
      return;
    }

    if (!this.element.contains(event.target)) {
      this.collapse();
    }
  }

  updateButtonState() {
    const buttons = document.querySelectorAll('.product-link');
    const isExpanded = this.element.classList.contains("expanded");

    buttons.forEach((button) => {
      const productCard = button.querySelector('.product-card');

      if (isExpanded) {
        button.disabled = true;
        if (productCard) {
          productCard.classList.add("disabled-card"); // Ajoute une classe au product-card
        }
      } else {
        setTimeout(() => {
          button.disabled = false;
          if (productCard) {
            productCard.classList.remove("disabled-card"); // Supprime la classe au product-card
          }
        }, 10); // Délai de 500 ms
      }
    });
  }

  preventDisabledButtonAction(event) {
    const button = event.target.closest('.product-link');
    console.log(button)
    if (button && button.disabled) {
      event.preventDefault();
      event.stopPropagation();
    }
  }
}
