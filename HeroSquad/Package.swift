// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "HeroSquad",
  platforms: [
    .macOS(.v11)
  ],
  products: [
    .library(
      name: "HeroSquad",
      targets: ["HeroSquad"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "HeroSquad",
      resources: [
        .process("Resources/Names.plist")
      ]
    )
  ]
)
