import CoreData

extension RequestEntity {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<RequestEntity> {
    return NSFetchRequest<RequestEntity>(entityName: "RequestEntity")
  }

  @NSManaged public var date: Date

  /// Denormalized in order to prevent firing the relationship fault when displaying rows of RequestEntity.
  @NSManaged public var squadName: String

  @NSManaged public var response: ResponseEntity

}

extension RequestEntity: Identifiable {}
