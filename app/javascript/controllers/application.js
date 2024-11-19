import { Application } from "@hotwired/stimulus"
import FlatpickrController from "./flatpickr_controller";

const application = Application.start()

application.debug = false
window.Stimulus   = application
application.register("flatpickr", FlatpickrController);

export { application }
