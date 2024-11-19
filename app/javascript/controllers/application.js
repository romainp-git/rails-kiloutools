import { Application } from "@hotwired/stimulus"
import DatepickerController from "./datepicker_controller";

const application = Application.start()

application.debug = false
window.Stimulus   = application
application.register("datepicker", DatepickerController);

export { application }
