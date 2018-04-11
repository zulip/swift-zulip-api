// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftZulipAPI",
    products: [
        Product.library(name: "SwiftZulipAPI", targets: ["SwiftZulipAPI"]),
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
            path: "tests/SwiftZulipAPI"
        ),
    ]
)
