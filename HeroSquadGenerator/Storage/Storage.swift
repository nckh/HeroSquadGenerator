import CoreData
import HeroSquad

protocol Storage: AnyObject {

  func saveRequest(_ squad: Squad, responseDataString: String)
  func makeRequestFetchedResultsController() -> NSFetchedResultsController<RequestEntity>

}
