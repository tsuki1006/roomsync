import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="participants"
export default class extends Controller {

  static targets = [ 'participantsList' ]

  displayParticipants() {

    if (this.hasParticipantsListTarget) {
      this.participantsListTarget.classList.toggle('hidden')
    }

  }
}
