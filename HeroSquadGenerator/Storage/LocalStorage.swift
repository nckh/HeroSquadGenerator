import AppKit
import OSLog
import HeroSquad

final class LocalStorage {

  private let container: NSPersistentContainer

  private lazy var backgroundContext: NSManagedObjectContext = {
    container.newBackgroundContext()
  }()

  init() {
    self.container = NSPersistentContainer(name: "Squad")

    container.loadPersistentStores { description, error in
      guard error == nil else {
        Logger.storage.error("Error loading persistent store: \(error!.localizedDescription)")
        return
      }

      Logger.storage.debug("Store loaded from \(description.url?.absoluteString ?? "?")")
    }

    container.viewContext.automaticallyMergesChangesFromParent = true
  }

}

// MARK: - Storage

extension LocalStorage: Storage {

  func saveRequest(_ squad: Squad, responseDataString: String) {
    let context = backgroundContext

    let responseEntity = ResponseEntity(context: context)
    responseEntity.data = Data(responseDataString.utf8)

    let requestEntity = RequestEntity(context: context)
    requestEntity.date = Date()
    requestEntity.squadName = squad.name
    requestEntity.response = responseEntity

    do {
      try context.save()
    } catch {
      Logger.storage.error("Error saving Core Data context: \(error.localizedDescription)")
    }

  }

  func makeRequestFetchedResultsController() -> NSFetchedResultsController<RequestEntity> {
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)

    let request = RequestEntity.fetchRequest()
    request.sortDescriptors = [sortDescriptor]

    let context = container.viewContext

    return NSFetchedResultsController(
      fetchRequest: request,
      managedObjectContext: context,
      sectionNameKeyPath: nil,
      cacheName: "RequestListCache"
    )
  }

}
