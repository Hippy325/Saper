import ProjectDescription

let swiftlintScript = """
echo "Start Swiftlint"
export PATH=$PATH:/opt/homebrew/bin/
mint run swiftlint@0.46.5 swiftlint
"""

let target = Target(
	name: "App",
	platform: .iOS,
	product: .app,
	bundleId: "garibyanTigran.App",
	deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
	infoPlist: "Saper/Info.plist",
	sources: ["Saper/**"],
	actions: [.pre(script: swiftlintScript, name: "SwiftLint")],
    dependencies: [
        .package(product: "SnapKit"),
        .package(product: "Kingfisher"),
        .package(product: "Firebase")
    ]
)

let project = Project(
    name: "Saper",
    packages: [
        .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "9.0.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.0.0")),
        .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMajor(from: "5.0.0")),
    ],
    targets: [target]
)
