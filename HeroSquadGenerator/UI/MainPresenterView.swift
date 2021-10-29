import CoreData

protocol MainPresenterView: AnyObject {

  func setFetchResultsController(_ fetchResultsController: NSFetchedResultsController<RequestEntity>)
  func setString(_ string: String)
  func selectRow(_ row: Int)
  func setWindowSubtitle(_ subtitle: String)

}
