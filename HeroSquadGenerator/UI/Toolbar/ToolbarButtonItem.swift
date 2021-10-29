import AppKit

/// A toolbar item with a large button as its view. 
final class ToolbarButtonItem {

  let toolbarItem: NSToolbarItem

  private let itemIdentifier: NSToolbarItem.Identifier
  private let actionHandler: ((NSToolbarItem.Identifier) -> Void)

  init(
    itemIdentifier: NSToolbarItem.Identifier,
    image: NSImage,
    actionHandler: @escaping (NSToolbarItem.Identifier) -> Void
  ) {
    self.itemIdentifier = itemIdentifier
    toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)

    self.actionHandler = actionHandler

    let button = NSButton(image: image, target: self, action: #selector(action(_:)))
    button.bezelStyle = .texturedRounded
    button.translatesAutoresizingMaskIntoConstraints = false
    button.widthAnchor.constraint(equalToConstant: 42).isActive = true

    toolbarItem.view = button
  }

  @objc private func action(_ sender: NSMenuItem) {
    actionHandler(itemIdentifier)
  }

}
