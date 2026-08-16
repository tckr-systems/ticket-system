import { Controller } from "@hotwired/stimulus"

// Reveals the hidden inline edit panel when a Turbo Frame finishes loading
// its content into it, and hides it again on cancel / after update.
export default class extends Controller {
  onFrameLoad = (event) => {
    const frame = (event.detail && event.detail.frame) || event.target
    if (frame === this.element || frame.id === "ticket_form_panel") {
      this.element.classList.remove("hidden")
    }
  }

  close() {
    this.element.classList.add("hidden")
  }

  connect() {
    document.addEventListener("turbo:frame-load", this.onFrameLoad)
  }

  disconnect() {
    document.removeEventListener("turbo:frame-load", this.onFrameLoad)
  }
}