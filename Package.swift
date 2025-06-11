// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription

let package = Package(
    name: "skipapp-hello-fuse",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        .library(name: "HelloSkipFuseApp", type: .dynamic, targets: ["HelloSkipFuse"]),
        .library(name: "HelloSkipUI", type: .dynamic, targets: ["HelloSkipUI"]),
        .library(name: "HelloSkipModel", type: .dynamic, targets: ["HelloSkipModel"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.6.0"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.29.3"),
        .package(url: "https://source.skip.tools/skip-model.git", from: "1.5.0"),
        .package(url: "https://source.skip.tools/skip-fuse-ui.git", from: "1.0.0"),
        .package(url: "https://source.skip.tools/skip-fuse.git", from: "1.0.2"),
    ],
    targets: [
        .target(name: "HelloSkipFuse", dependencies: [
            "HelloSkipUI",
            .product(name: "SkipUI", package: "skip-ui")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .target(name: "HelloSkipUI", dependencies: [
            "HelloSkipModel",
            .product(name: "SkipFuseUI", package: "skip-fuse-ui"),
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .target(name: "HelloSkipModel", dependencies: [
            .product(name: "SkipFuse", package: "skip-fuse"),
            .product(name: "SkipModel", package: "skip-model")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "HelloSkipModelTests", dependencies: [
            "HelloSkipModel",
            .product(name: "SkipTest", package: "skip")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
