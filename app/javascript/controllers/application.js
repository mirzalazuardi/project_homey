import { Application } from "@hotwired/stimulus"

const application = Application.start()
import HwComboboxController from "@josefarias/hotwire_combobox"
application.register("hw-combobox", HwComboboxController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
