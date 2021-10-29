import CoreData
import RemoteService
import OSLog

final class MainPresenter {

  weak var presenterView: MainPresenterView? {
    didSet {
      presenterView?.setFetchResultsController(fetchedResultsController)
      presenterView?.setWindowSubtitle(defaultWindowSubtitle)
    }
  }

  private let squadRequestManager: SquadRequestManager
  private let fetchedResultsController: NSFetchedResultsController<RequestEntity>
  private var defaultWindowSubtitle: String = ""

  init(remoteService: RemoteServiceProtocol, storage: Storage) {
    squadRequestManager = SquadRequestManager(remoteService: remoteService, storage: storage)
    fetchedResultsController = storage.makeRequestFetchedResultsController()

    do {
      try fetchedResultsController.performFetch()
      updateDefaultWindowSubtitle()
    } catch {
      Logger.default.error("Error performing fetch: \(error.localizedDescription)")
    }
  }

  private func updateDefaultWindowSubtitle() {
    defaultWindowSubtitle = "\(numberOfSquads) Hero Squads"
  }

  private func revertToDefaultWindowSubtitle() {
    presenterView?.setWindowSubtitle(defaultWindowSubtitle)
  }

}

extension MainPresenter: MainPresenting {

  private var numberOfSquads: Int {
    guard let section = fetchedResultsController.sections?.first else { return 0 }
    return section.numberOfObjects
  }

  func createNewSquad() {
    presenterView?.setWindowSubtitle("Saving a New Squad...")

    squadRequestManager.createNewSquad { [weak self] in
      self?.updateDefaultWindowSubtitle()

      DispatchQueue.main.async { [weak self] in
        self?.revertToDefaultWindowSubtitle()
        self?.selectLatestSquad()
      }
    }
  }

  func showResponse(from request: RequestEntity) {
    let response = request.response
    presenterView?.setString(response.data.jsonStringFormatted())
  }

  func selectLatestSquad() {
    guard let request = request(atRow: 0) else { return }
    presenterView?.selectRow(0)
    showResponse(from: request)
  }

  func didSelect(_ request: RequestEntity) {
    showResponse(from: request)
  }

  private func request(atRow row: Int) -> RequestEntity? {
    guard numberOfSquads > 0 else { return nil }
    return fetchedResultsController.object(at: IndexPath(item: row, section: 0))
  }

}
