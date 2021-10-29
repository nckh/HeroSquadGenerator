import AppKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

  private var coordinator: Coordinator?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    coordinator = Coordinator()
  }

  func applicationWillTerminate(_ aNotification: Notification) {}

  func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

}
