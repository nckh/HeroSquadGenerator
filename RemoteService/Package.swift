// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "RemoteService",
  products: [
    .library(
      name: "RemoteService",
      targets: ["RemoteService"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "RemoteService",
      dependencies: []
    ),
    .testTarget(
      name: "RemoteServiceTests",
      dependencies: ["RemoteService"]
    )
  ]
)
