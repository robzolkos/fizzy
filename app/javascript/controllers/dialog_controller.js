import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "dialog" ]
  static values = {
    modal: { type: Boolean, default: false }
  }

  connect() {
    this.dialogTarget.setAttribute('aria-hidden', 'true')
  }

  open() {
    const modal = this.modalValue

    if (modal) {
      this.dialogTarget.showModal()
    } else {
      this.dialogTarget.show()
    }
    this.dialogTarget.setAttribute('aria-hidden', 'false')
  }

  toggle() {
    if (this.dialogTarget.open) {
      this.close()
    } else {
      this.open()
    }
  }

  close() {
    this.dialogTarget.close()
    this.dialogTarget.setAttribute('aria-hidden', 'true')
    this.dialogTarget.blur()
  }

  closeOnClickOutside({ target }) {
    if (!this.element.contains(target)) this.close()
  }
}
