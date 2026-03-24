import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = (window.location.hostname === 'localhost')
window.Stimulus   = application

export { application }
