import AppKit
import RemoteService

final class Coordinator: NSResponder {

  private let windowController: NSWindowController
  private let presenter: MainPresenter

  private var mainViewController: MainViewController? {
    guard let mvc = windowController.contentViewController as? MainViewController else {
      fatalError("View controller is not a MainViewController instance")
    }
    return mvc
  }

  override init() {
    let controllerFactory = ControllerFactory()

    let toolbarConfigurator = ToolbarConfigurator()
    windowController = controllerFactory.makeMakeWindowController(toolbarConfigurator: toolbarConfigurator)

    let remoteService = RemoteService()
    let storage = LocalStorage()

    presenter = MainPresenter(remoteService: remoteService, storage: storage)

    super.init()

    toolbarConfigurator.actionHandler = { [weak self] itemIdentifier in
      switch itemIdentifier {
      case .newSquad: self?.createNewSquad()
      default: break
      }
    }

    presenter.presenterView = mainViewController
    mainViewController?.presenter = presenter

    windowController.nextResponder = self
    windowController.window?.makeKeyAndOrderFront(nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func createNewSquad() {
    presenter.createNewSquad()
  }

  @IBAction private func createNewSquad(_ sender: Any) {
    createNewSquad()
  }

}
