// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "WalletCore",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "WalletCore", targets: ["WalletCore"]),
        .library(name: "SwiftProtobuf", targets: ["SwiftProtobuf"])
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "WalletCore",
            url: "https://github.com/trustwallet/wallet-core/releases/download/4.1.17/WalletCore.xcframework.zip",
            checksum: "babdce6cfc1644f28b233ea8af952befa165b1281ce66d5531a87eb6ad917b1f"
        ),
        .binaryTarget(
            name: "SwiftProtobuf",
            url: "https://github.com/trustwallet/wallet-core/releases/download/4.1.17/SwiftProtobuf.xcframework.zip",
            checksum: "c7a3d274e6d9c44d348c540e444c0483156fb4ae390390e680468ba8217dcf38"
        )
    ]
)
