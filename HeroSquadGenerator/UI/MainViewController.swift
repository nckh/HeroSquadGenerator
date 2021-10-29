import AppKit

final class MainViewController: NSSplitViewController {

  var presenter: MainPresenting? {
    didSet {
      presenter?.selectLatestSquad()
    }
  }

  private var listViewController: SquadListViewController {
    guard let vc = listSplitViewItem.viewController as? SquadListViewController else {
      fatalError("View controller must be a SquadListViewController instance")
    }
    return vc
  }

  private var responseViewController: ResponseViewController {
    guard let vc = responseSplitViewItem.viewController as? ResponseViewController else {
      fatalError("View controller must be a ResponseViewController instance")
    }
    return vc
  }

  @IBOutlet private var listSplitViewItem: NSSplitViewItem!
  @IBOutlet private var responseSplitViewItem: NSSplitViewItem!

  override func viewDidLoad() {
    super.viewDidLoad()

    listViewController.delegate = self
  }

}

extension MainViewController: MainPresenterView {

  func setFetchResultsController(_ fetchResultsController: NSFetchedResultsController<RequestEntity>) {
    listViewController.fetchedResultsController = fetchResultsController
  }

  func setString(_ string: String) {
    responseViewController.string = string
  }

  func selectRow(_ row: Int) {
    listViewController.selectRow(row)
  }

  func setWindowSubtitle(_ subtitle: String) {
    view.window?.subtitle = subtitle
  }

}

extension MainViewController: SquadListViewControllerDelegate {

  func squadListViewController(_ squadListViewController: SquadListViewController, didSelect request: RequestEntity) {
    presenter?.didSelect(request)
  }

}
