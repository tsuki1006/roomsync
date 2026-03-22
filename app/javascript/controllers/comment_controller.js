import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {

  static targets = [ 'userComment' ]

  displayUserComment() {

    if (this.hasUserCommentTarget) {
      this.userCommentTarget.classList.toggle('hidden')
    }

  }
}
