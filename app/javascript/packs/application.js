import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "chartkick/chart.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
require("jquery")
import "bootstrap"
import Swal from "sweetalert2/dist/sweetalert2.js"
window.Swal = Swal;
