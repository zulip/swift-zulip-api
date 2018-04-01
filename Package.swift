import PackageDescription

let package = Package(
    name: "ZulipSwift",
    products: [
        Product.library(name: "ZulipSwift", targets: ["ZulipSwift"]),
    ],
    targets: [
        Target.target(
            name: "ZulipSwift",
        ),
        Target.testTarget(
            name: "ZulipSwiftTests",
            dependencies: ["ZulipSwift"],
        ),
    ]
)
