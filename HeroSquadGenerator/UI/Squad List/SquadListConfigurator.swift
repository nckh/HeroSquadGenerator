import AppKit
import CoreData
import OSLog

/// An object that feeds a table view of squads.
final class SquadListConfigurator: NSObject {

  var selectionDidChangeHandler: ((RequestEntity) -> Void)?

  private weak var tableView: NSTableView?
  private let fetchedResultsController: NSFetchedResultsController<RequestEntity>

  init(tableView: NSTableView, fetchedResultsController: NSFetchedResultsController<RequestEntity>) {
    self.tableView = tableView
    self.fetchedResultsController = fetchedResultsController

    super.init()

    fetchedResultsController.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
  }

}

// MARK: - NSTableViewDataSource

extension SquadListConfigurator: NSTableViewDataSource {

  func numberOfRows(in tableView: NSTableView) -> Int {
    guard let section = fetchedResultsController.sections?.first else { return 0 }
    return section.numberOfObjects
  }

}

// MARK: - NSTableViewDelegate

extension SquadListConfigurator: NSTableViewDelegate {

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let id = CellIdentifiers.squadCell
    guard let cell = tableView.makeView(withIdentifier: id, owner: nil) as? NSTableCellView else {
      fatalError("Missing cell \"\(id)\" in storyboard")
    }

    let entity = fetchedResultsController.object(at: IndexPath(item: row, section: 0))
    cell.textField?.stringValue = entity.squadName

    return cell
  }

  func tableViewSelectionDidChange(_ notification: Notification) {
    guard let row = tableView?.selectedRow else { return }
    let entity = fetchedResultsController.object(at: IndexPath(item: row, section: 0))
    selectionDidChangeHandler?(entity)
  }

  enum CellIdentifiers {
    static let squadCell = NSUserInterfaceItemIdentifier(rawValue: "SquadCell")
  }

}

// MARK: - NSFetchedResultsControllerDelegate

extension SquadListConfigurator: NSFetchedResultsControllerDelegate {

  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView?.beginUpdates()
  }

  func controller(
    _ controller: NSFetchedResultsController<NSFetchRequestResult>,
    didChange anObject: Any,
    at indexPath: IndexPath?,
    for type: NSFetchedResultsChangeType,
    newIndexPath: IndexPath?
  ) {
    switch type {
    case .insert:
      guard let indexPath = newIndexPath else {
        Logger.default.error("indexPath should not be nil")
        return
      }

      tableView?.insertRows(at: IndexSet(indexPath), withAnimation: [])

    default: break
    }
  }

  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView?.endUpdates()
  }

}
