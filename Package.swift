// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RUIKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "RUIKit",
            targets: ["RUIKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/leerachel5/RThemeEngine.git", branch: "main")
    ],
    targets: [
        .target(
            name: "RUIKit",
            dependencies: ["RThemeEngine"],
            path: "Sources"
        )
    ]
)
