// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PatreonAPI-Swift",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PatreonAPI",
            targets: ["PatreonAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.1"),
        .package(url: "https://github.com/groue/Semaphore.git", from: "0.0.6"),
        .package(url: "https://github.com/Flight-School/AnyCodable.git", from: "0.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PatreonAPI",
            dependencies: [
                "Alamofire",
                "Semaphore",
                "AnyCodable"
            ]
        ),
        .testTarget(
            name: "PatreonAPI-Tests",
            dependencies: ["PatreonAPI"]
        ),
    ]
)
