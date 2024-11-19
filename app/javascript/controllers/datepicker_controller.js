import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
import "flatpickr/dist/plugins/rangePlugin";

export default class extends Controller {
  static targets = ["startDate", "endDate","amount", "pricePerDay"];
  connect() {

    flatpickr(this.startDateTarget, {
      mode: "range",
      plugins: [new rangePlugin({ input: this.endDateTarget })],
      altInput: true,
      altFormat: "d-m-Y",
      dateFormat: "Y-m-d",
      onChange: this.handleDateChange.bind(this)
    });
  }

  handleDateChange(selectedDates) {
    const startDate = selectedDates[0];
    let endDate = selectedDates[1];
    if (startDate.getTime() === endDate.getTime()) {
      endDate = new Date(endDate);
      endDate.setDate(endDate.getDate() + 1);
    }
    this.startDateTarget.value = this.formatDate(startDate);

    const days = (endDate - startDate) / (1000 * 60 * 60 * 24);

    const pricePerDay = this.pricePerDayTarget.value;
    const amount = days * pricePerDay;
    this.amountTarget.value = amount.toFixed(2);
  }

  formatDate(date) {
    const day = String(date.getDate()).padStart(2, "0");
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const year = date.getFullYear();
    return `${day}-${month}-${year}`;
  }
}
