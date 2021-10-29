/// A value representing a repository of various names.
struct NameList: Decodable {

  let cities: [String]
  let maleNames: [String]
  let femaleNames: [String]
  let heroNames: [String]
  let powers: [String]
  let squads: [String]

  private enum CodingKeys: String, CodingKey {
    case cities = "Cities"
    case maleNames = "MaleNames"
    case femaleNames = "FemaleNames"
    case heroNames = "HeroNames"
    case powers = "Powers"
    case squads = "Squads"
  }

}
