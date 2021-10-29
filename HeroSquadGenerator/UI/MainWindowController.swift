import AppKit

final class MainWindowController: NSWindowController {

  var toolbarConfigurator: ToolbarConfigurator? {
    didSet {
      let toolbar = NSToolbar(identifier: "Toolbar")
      toolbar.allowsUserCustomization = true
      toolbar.displayMode = .iconOnly
      toolbar.delegate = toolbarConfigurator

      window?.toolbar = toolbar
    }
  }

  override func windowDidLoad() {
    super.windowDidLoad()

    windowFrameAutosaveName = "MainWindow"
    window?.contentMinSize = NSSize(width: 500, height: 500)
    window?.setContentSize(NSSize(width: 700, height: 800))
  }

}
