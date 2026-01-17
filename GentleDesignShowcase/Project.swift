import ProjectDescription

let project = Project(
    name: "GentleDesignShowcase",
    packages: [
        .remote(url: "https://github.com/gentle-giraffe-apps/SmartAsyncImage", requirement: .exact("0.1.1")),
        .remote(url: "https://github.com/gentle-giraffe-apps/GentleDesignSystem", requirement: .exact("0.1.5")),
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
        )
    ]
)
