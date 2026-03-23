import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="help"
export default class extends Controller {

  static targets = [ 'helpModal' ]

  open() {
    this.helpModalTarget.classList.remove('hidden')
    document.body.style.overflow = 'hidden'
  }

  close() {
    this.helpModalTarget.classList.add('hidden')
    document.body.style.overflow = ''
  }
}
