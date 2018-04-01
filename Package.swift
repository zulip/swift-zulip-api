// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "ZulipSwift",
    products: [
        Product.library(name: "ZulipSwift", targets: ["ZulipSwift"]),
    ],
    targets: [
        Target.target(
            name: "ZulipSwift",
            path: "sources/ZulipSwift"
        ),
        Target.testTarget(
            name: "ZulipSwiftTests",
            dependencies: ["ZulipSwift"],
            path: "tests/ZulipSwift"
        ),
    ]
)
