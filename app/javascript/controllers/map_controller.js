import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log(this.element.dataset.mapMarkersValue);
    mapboxgl.accessToken = this.apiKeyValue;

    const map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [2.3522, 48.8566], // Centre initial (ici Paris)
      zoom: 12
    });

    // Ajouter les markers
    this.markersValue.forEach((marker) => {
      const el = document.createElement("div");
      el.className = "marker";
      el.style.backgroundImage = 'url("https://docs.mapbox.com/help/demos/custom-markers-gl-js/mapbox-icon.png")';
      el.style.width = "30px";
      el.style.height = "30px";
      el.style.backgroundSize = "cover";

      new mapboxgl.Marker(el)
        .setLngLat([marker.lng, marker.lat])
        .addTo(map);
    });

    // Ajuster les bounds
    if (this.markersValue.length) {
      const bounds = new mapboxgl.LngLatBounds();
      this.markersValue.forEach((marker) =>
        bounds.extend([marker.lng, marker.lat])
      );
      map.fitBounds(bounds, { padding: 50, maxZoom: 15, duration: 0 });
    }
  }
}
