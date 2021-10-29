import AppKit

final class ControllerFactory {

  private let storyboard = NSStoryboard(name: "Main", bundle: nil)

  func makeMakeWindowController(toolbarConfigurator: ToolbarConfigurator) -> MainWindowController {
    let id = StoryboardIdentifier.mainWindow
    guard let wc = storyboard.instantiateController(withIdentifier: id) as? MainWindowController else {
      fatalError("Could not find controller \"\(id)\" in storyboard")
    }
    wc.toolbarConfigurator = toolbarConfigurator
    return wc
  }

  private enum StoryboardIdentifier {
    static let mainWindow = "MainWindow"
  }

}
