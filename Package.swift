// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftZulipAPI",
    products: [
        Product.library(name: "SwiftZulipAPI", targets: ["SwiftZulipAPI"]),
        Product.library(
            name: "SwiftZulipAPIBots",
            targets: ["SwiftZulipAPIBots"]
        ),
        Product.executable(
            name: "SwiftZulipAPIExample",
            targets: ["SwiftZulipAPIExample"]
        ),
        Product.executable(
            name: "SwiftZulipAPIBotRunner",
            targets: ["SwiftZulipAPIBotRunner"]
        ),
    ],
    dependencies: [
        Package.Dependency.package(
            url: "https://github.com/Alamofire/Alamofire.git",
            from: "4.0.0"
        ),
    ],
    targets: [
        Target.target(
            name: "SwiftZulipAPI",
            dependencies: ["Alamofire"],
            path: "sources/SwiftZulipAPI"
        ),
        Target.testTarget(
            name: "SwiftZulipAPITests",
            dependencies: ["SwiftZulipAPI"],
            path: "tests/SwiftZulipAPITests"
        ),
        Target.target(
            name: "SwiftZulipAPIExample",
            dependencies: ["SwiftZulipAPI"],
            path: "example/SwiftZulipAPIExample"
        ),
        Target.target(
            name: "SwiftZulipAPIBots",
            dependencies: ["SwiftZulipAPI"],
            path: "bots/sources/SwiftZulipAPIBots"
        ),
        Target.target(
            name: "SwiftZulipAPIBotRunner",
            dependencies: ["SwiftZulipAPIBots"],
            path: "bots/runner/SwiftZulipAPIBotRunner"
        ),
        Target.testTarget(
            name: "SwiftZulipAPIBotTests",
            dependencies: ["SwiftZulipAPIBots"],
            path: "bots/tests/SwiftZulipAPIBotTests"
        ),
    ]
)
