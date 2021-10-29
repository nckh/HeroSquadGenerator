public struct Hero: Hashable, Encodable {

  public let name: String
  public let secretIdentity: String
  public let age: Int
  public let powers: Set<Power>

  init(name: String, secretIdentity: String, age: Int, powers: Set<Power>) {
    self.name = name
    self.secretIdentity = secretIdentity
    self.age = age
    self.powers = powers
  }

}

public typealias Power = String
