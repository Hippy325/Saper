import ProjectDescription

let target = Target(
	name: "App",
	platform: .iOS,
	product: .app,
	bundleId: "garibyanTigran.App",
	deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
	infoPlist: "Saper/Info.plist",
	sources: ["Saper/**"]
)

let project = Project(name: "Saper", targets: [target])
