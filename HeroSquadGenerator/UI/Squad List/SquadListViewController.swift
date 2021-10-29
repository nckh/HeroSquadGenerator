import AppKit
import OSLog

final class SquadListViewController: NSViewController {

  var fetchedResultsController: NSFetchedResultsController<RequestEntity>? {
    didSet {
      guard let fetchedResultsController = fetchedResultsController else { return }

      listConfigurator = SquadListConfigurator(
        tableView: tableView,
        fetchedResultsController: fetchedResultsController
      )

      listConfigurator?.selectionDidChangeHandler = { [weak delegate] request in
        delegate?.squadListViewController(self, didSelect: request)
      }
    }
  }

  weak var delegate: SquadListViewControllerDelegate?

  @IBOutlet private weak var tableView: NSTableView!
  private var listConfigurator: SquadListConfigurator?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func selectRow(_ row: Int) {
    let indexSet = IndexSet(IndexPath(item: row, section: 0))
    tableView.selectRowIndexes(indexSet, byExtendingSelection: false)
  }

}
