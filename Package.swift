// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Ocean",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "OceanTokens",
            targets: ["OceanTokens"]
        ),
        .library(
            name: "OceanComponents",
            targets: ["OceanComponents"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ivanvorobei/SPStorkController", from: "1.8.5"),
        .package(url: "https://github.com/WenchaoD/FSCalendar", from: "2.8.4"),
        .package(url: "https://github.com/Juanpe/SkeletonView", .upToNextMajor(from: "1.31.0")),
        .package(url: "https://github.com/SDWebImage/SDWebImage", from: "5.19.0"),
        .package(url: "https://github.com/danielgindi/Charts.git", .upToNextMajor(from: "5.1.0")),
        .package(url: "https://github.com/teodorpatras/EasyTipView", from: "2.1.0")
    ],
    targets: [
        .target(
            name: "OceanTokens",
            dependencies: [],
            path: "Sources/OceanTokens",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "OceanComponents",
            dependencies: ["OceanTokens",
                           .product(name: "SPStorkController", package: "SPStorkController"),
                           .product(name: "FSCalendar", package: "FSCalendar"),
                           .product(name: "SkeletonView", package: "SkeletonView"),
                           .product(name: "SDWebImage", package: "SDWebImage"),
                           .product(name: "DGCharts", package: "Charts"),
                           .product(name: "EasyTipView", package: "EasyTipView")],
            path: "Sources/OceanComponents",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
