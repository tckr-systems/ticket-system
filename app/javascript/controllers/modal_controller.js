import { Controller } from "@hotwired/stimulus"

// Closes the buyer-details modal: Escape anywhere, or clicking a close
// affordance inside the modal clears the turbo-frame that holds it.
export default class extends Controller {
  close() {
    const frame = document.getElementById("ticket_modal")
    if (frame) frame.innerHTML = ""
  }

  onKeydown = (event) => {
    if (event.key === "Escape") this.close()
  }

  connect() {
    document.addEventListener("keydown", this.onKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.onKeydown)
  }
}