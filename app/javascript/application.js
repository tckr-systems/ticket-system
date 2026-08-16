import "@hotwired/turbo-rails"
import "controllers"

// Poof: intercept Turbo Stream "remove" actions and fade the row out
// before Turbo deletes it, then finish the removal after the animation.
document.addEventListener("turbo:before-stream-render", (event) => {
  const stream = event.target

  if (!(stream instanceof HTMLElement)) return
  if (stream.getAttribute("action") !== "remove") return

  const targetId = stream.getAttribute("target")
  const element = targetId ? document.getElementById(targetId) : null
  if (!element || getComputedStyle(element).display === "none") return

  event.preventDefault()

  element.classList.add("ticket-row--poof")
  element.addEventListener(
    "animationend",
    () => element.remove(),
    { once: true }
  )
})