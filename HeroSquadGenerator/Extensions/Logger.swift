import OSLog

extension Logger {

  static let `default` = Logger(subsystem: "com.nckh.HeroSquadGenerator", category: "Default")
  static let storage = Logger(subsystem: "com.nckh.HeroSquadGenerator", category: "Storage")
  static let networking = Logger(subsystem: "com.nckh.HeroSquadGenerator", category: "Networking")

}
