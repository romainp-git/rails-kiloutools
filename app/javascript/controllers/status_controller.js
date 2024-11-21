import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  updateStatus(event) {
    const bookingId = event.target.dataset.bookingId;
    const newStatus = event.target.value;

    if (!confirm('Êtes-vous sûr de vouloir changer le statut de cette réservation ?')) {

      return;
    }
    fetch(`/bookings/${bookingId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        booking: {
          status: newStatus,
        },
      }),
    })
    .then(response => response.json())
    .then(data => {
      location.reload();
    })
  }
}
