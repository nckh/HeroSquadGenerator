import AppKit

/// An object that configures a window toolbar.
final class ToolbarConfigurator: NSObject {

  var actionHandler: ((NSToolbarItem.Identifier) -> Void)?

  private var toolbarButtonItems = [ToolbarButtonItem]()

}

// MARK: - NSToolbarDelegate

extension ToolbarConfigurator: NSToolbarDelegate {

  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    [.newSquad]
  }

  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    [.newSquad]
  }

  func toolbar(
    _ toolbar: NSToolbar,
    itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
    willBeInsertedIntoToolbar flag: Bool
  ) -> NSToolbarItem? {
    switch itemIdentifier {
    case .newSquad:
      guard let image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil) else {
        fatalError("Could not create image")
      }

      let buttonItem = ToolbarButtonItem(itemIdentifier: itemIdentifier, image: image) { [weak self] itemIdentifier in
        self?.actionHandler?(itemIdentifier)
      }

      toolbarButtonItems.append(buttonItem)

      buttonItem.toolbarItem.label = "New Squad"
      buttonItem.toolbarItem.toolTip = "Create a New Squad"
      return buttonItem.toolbarItem

    default: return nil
    }
  }

}

// MARK: - NSToolbarItem.Identifier

extension NSToolbarItem.Identifier {

  static let newSquad = NSToolbarItem.Identifier("New Squad")

}
