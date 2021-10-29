import OSLog

public struct Squad: Hashable, Encodable {

  public let name: String
  public let homeTown: String
  public let yearFormed: Int
  public let isActive: Bool
  public let members: Set<Hero>

  enum CodingKeys: String, CodingKey {
    case name, homeTown, members
    case yearFormed = "formed"
    case isActive = "active"
  }

}

extension Squad {

  public static func random(
    memberCountRange: ClosedRange<Int> = 3...5,
    ageRange: ClosedRange<Int> = 14...55,
    yearFormedRange: ClosedRange<Int> = 1900...2021,
    powerCountRange: ClosedRange<Int> = 2...5
  ) -> Self? {
    do {
      let nameProvider = try NameProvider()

      let members: [Hero] = memberCountRange.zeroLowerBoundRandomUpperBoundRange().map { index in
        let secretIdentity: String
        if index % 2 == 0 {
          secretIdentity = nameProvider.randomMaleName()
        } else {
          secretIdentity = nameProvider.randomFemaleName()
        }

        let powers = powerCountRange.zeroLowerBoundRandomUpperBoundRange().map { _ in
          nameProvider.randomPower()
        }

        return Hero(
          name: nameProvider.randomHeroName(),
          secretIdentity: secretIdentity,
          age: ageRange.randomElement() ?? 0,
          powers: Set(powers)
        )
      }

      return Squad(
        name: nameProvider.randomSquad(),
        homeTown: nameProvider.randomCity(),
        yearFormed: yearFormedRange.randomElement() ?? 0,
        isActive: Bool.random(),
        members: Set(members)
      )

    } catch {
      Logger.default.error("Error generating squad: \(error.localizedDescription)")
      return nil
    }
  }

}
