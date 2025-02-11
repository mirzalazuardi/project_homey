import { Application } from "@hotwired/stimulus"

const application = Application.start()
import RailsNestedForm from '@stimulus-components/rails-nested-form'
import HwComboboxController from "@josefarias/hotwire_combobox"
application.register('nested-form', RailsNestedForm)
application.register("hw-combobox", HwComboboxController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
