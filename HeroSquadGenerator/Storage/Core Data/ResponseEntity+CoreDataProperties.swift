import CoreData

extension ResponseEntity {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<ResponseEntity> {
    return NSFetchRequest<ResponseEntity>(entityName: "ResponseEntity")
  }

  @NSManaged public var data: Data

}

extension ResponseEntity: Identifiable {}
