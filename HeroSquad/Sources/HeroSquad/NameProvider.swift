import Foundation

/// An object generating random names.
final class NameProvider {

  private let nameList: NameList

  init() throws {
    guard let url = Bundle.module.url(forResource: "Names", withExtension: "plist") else {
      fatalError("Could not find Heroes.plist in module")
    }

    let decoder = PropertyListDecoder()
    do {
      let data = try Data(contentsOf: url)
      let nameList = try decoder.decode(NameList.self, from: data)
      self.nameList = nameList
    }
  }

  func randomCity() -> String { nameList.cities.randomElement() ?? "" }
  func randomMaleName() -> String { nameList.maleNames.randomElement() ?? "" }
  func randomFemaleName() -> String { nameList.femaleNames.randomElement() ?? "" }
  func randomHeroName() -> String { nameList.heroNames.randomElement() ?? "" }
  func randomPower() -> String { nameList.powers.randomElement() ?? "" }
  func randomSquad() -> String { nameList.squads.randomElement() ?? "" }

}
