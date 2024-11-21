import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mapbox-autocomplete"
export default class extends Controller {
  static targets = ["input", "results"];
  static values = { apiKey: String }

  connect() {
    this.baseUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
    this.list = document.createElement("ul");
    document.addEventListener("click", this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
  }

  search(event) {
    const query = event.target.value;

    if (query.length < 3) {
      this.list.innerHTML = "";
      return;
    }

    fetch(`${this.baseUrl}${encodeURIComponent(query)}.json?country=fr&types=place&access_token=${this.apiKeyValue}&autocomplete=true`)
      .then((response) => response.json())
      .then((data) => {
        this.updateResults(data.features);
        console.log(data.features);
      });
  }

  updateResults(features) {
    this.resultsTarget.appendChild(this.list);
    this.list.innerHTML = "";

    features.forEach((feature) => {
      const item = document.createElement("li");
      item.textContent = feature.place_name;
      item.addEventListener("click", () => this.selectSuggestion(feature));
      this.list.appendChild(item);
    });
  }

  selectSuggestion(feature) {
    this.inputTarget.value = feature.place_name;
    this.resultsTarget.innerHTML = "";
  }

  handleClickOutside(event) {
    if (!this.inputTarget.contains(event.target) && !this.list.contains(event.target)) {
      this.resultsTarget.removeChild(this.list);
    }
  }
}
