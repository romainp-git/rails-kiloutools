import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  updateStatus(event) {
    const bookingId = event.target.dataset.bookingId; // Récupère l'ID de la réservation
    const newStatus = event.target.value; // Récupère le nouveau statut

    // Demander confirmation avant de mettre à jour
    if (!confirm('Êtes-vous sûr de vouloir changer le statut de cette réservation ?')) {
      // Si l'utilisateur annule, on arrête l'exécution
      return;
    }

    // Envoi de la requête PATCH avec le token CSRF
    fetch(`/bookings/${bookingId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content // Assurez-vous d'inclure le token CSRF
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
