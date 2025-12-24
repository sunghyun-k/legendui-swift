// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "legendui-swift",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "LegendUI",
            targets: ["LegendUI"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/swiftui-introspect", Version("1.0.0")..<Version("27.0.0"))
    ],
    targets: [
        .target(
            name: "LegendUI",
            dependencies: [
                .product(name: "SwiftUIIntrospect", package: "swiftui-introspect"),
            ],
            resources: [
                .process("Resources"),
            ],
        ),
    ],
)
