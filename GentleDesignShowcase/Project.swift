import ProjectDescription

let project = Project(
    name: "GentleDesignShowcase",
    options: .options(
        automaticSchemesOptions: .disabled
    ),
    packages: [
        .remote(url: "https://github.com/gentle-giraffe-apps/SmartAsyncImage", requirement: .exact("0.1.1")),
        .remote(url: "https://github.com/gentle-giraffe-apps/GentleDesignSystem", requirement: .exact("0.1.11")),
        .remote(url: "https://github.com/pointfreeco/swift-snapshot-testing", requirement: .upToNextMajor(from: "1.15.0")),
        .remote(url: "https://github.com/alexey1312/SnapshotTestingHEIC.git", requirement: .upToNextMajor(from: "1.6.0"))
    ],
    settings: .settings(
        base: [
            "SWIFT_VERSION": "6.0"
        ]
    ),
    targets: [
        .target(
            name: "GentleDesignShowcase",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.GentleDesignShowcase",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            resources: [
                "GentleDesignShowcase/Assets.xcassets",
            ],
            buildableFolders: [
                "GentleDesignShowcase/App",
                "GentleDesignShowcase/Core",
                "GentleDesignShowcase/Features",
                "GentleDesignShowcase/Navigation",
                "GentleDesignShowcase/Tabs",
                "GentleDesignShowcase/UI",
            ],
            dependencies: [
                .package(product: "SmartAsyncImage"),
                .package(product: "GentleDesignSystem"),
            ]
        ),
        .target(
            name: "GentleDesignShowcaseTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.GentleDesignShowcaseTests",
            sources: ["GentleDesignShowcaseTests/**"],
            dependencies: [
                .target(name: "GentleDesignShowcase"),
                .package(product: "SnapshotTesting"),
                .package(product: "SnapshotTestingHEIC"),
            ]
        )
    ],
    schemes: [
        .scheme(
            name: "GentleDesignShowcase",
            shared: true,
            buildAction: .buildAction(targets: ["GentleDesignShowcase"]),
            testAction: .targets(["GentleDesignShowcaseTests"]),
            runAction: .runAction(configuration: .debug, executable: "GentleDesignShowcase")
        ),
        .scheme(
            name: "GentleDesignShowcaseTests",
            shared: true,
            buildAction: .buildAction(targets: ["GentleDesignShowcaseTests"]),
            testAction: .targets(["GentleDesignShowcaseTests"])
        )
    ]
)
