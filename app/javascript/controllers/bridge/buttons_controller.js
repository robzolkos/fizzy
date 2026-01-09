import { BridgeComponent } from "@hotwired/hotwire-native-bridge"
import { BridgeElement } from "@hotwired/hotwire-native-bridge"

export default class extends BridgeComponent {
  static component = "buttons"
  static targets = [ "button" ]

  buttonTargetConnected(element) {
    this.notifyBridgeOfConnect()
  }

  notifyBridgeOfConnect() {
    const buttons = this.buttonTargets
      .filter(target => !target.closest("[data-bridge-disabled]"))
      .map((target, index) => {
        const element = new BridgeElement(target)
        return { ...element.getButton(), index }
    })

    this.send("connect", { buttons }, message => {
      this.clickButton(message)
    })
  }

  clickButton(message) {
    const selectedIndex = message.data.selectedIndex
    this.buttonTargets[selectedIndex].click()
  }
}
