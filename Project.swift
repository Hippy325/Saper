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
	actions: [.pre(script: swiftlintScript, name: "SwiftLint")]
)

let project = Project(name: "Saper", targets: [target])
