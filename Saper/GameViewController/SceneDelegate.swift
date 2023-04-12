//
//  SceneDelegate.swift
//  Saper
//
//  Created by User on 26.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		let viewConreollerRouter = GameViewControllerRouter(settingsViewController: SettingsViewControllerAssembly())
		let lision = Liaison()
		let creator = CreatingCells(liaison: lision)
		let creatingStackView = CreatingStackView(creatingCells: creator)
		let presenter = GameViewControllerPresenter(liaison: lision, router: viewConreollerRouter)
		lision.setPresenter(presenter: presenter)

		let viewController = GameViewController(
			creatingStackView: creatingStackView,
			presenter: presenter
		)
		presenter.view = viewController
		viewConreollerRouter.viewController = viewController

		guard let scene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: scene)
		window?.makeKeyAndVisible()
		window?.rootViewController = viewController
	}

	func sceneDidDisconnect(_ scene: UIScene) {
	}

	func sceneDidBecomeActive(_ scene: UIScene) {
	}

	func sceneWillResignActive(_ scene: UIScene) {
	}

	func sceneWillEnterForeground(_ scene: UIScene) {
	}

	func sceneDidEnterBackground(_ scene: UIScene) {
	}

}
