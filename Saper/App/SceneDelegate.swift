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
		let viewConreollerRouter = GameRouter(settingsViewControllerAssembly: SettingsViewControllerAssembly())
		let lision = Liaison()
		let creator = CellsFactory(liaison: lision)
		let creatingStackView = FactoryStackView(factory: creator)
		let presenter = GamePresenter(liaison: lision, router: viewConreollerRouter)
		lision.setPresenter(presenter: presenter)

		let viewController = GameViewController(
			factoryStackView: creatingStackView,
			presenter: presenter
		)
		presenter.view = viewController
		viewConreollerRouter.viewController = viewController

		guard let scene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: scene)
		window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        let authViewController = AuthorizationViewControllerAssembly(navigationController: navigationController).assembly()
        navigationController.viewControllers = [authViewController]
        
        window?.rootViewController = GameViewControllerAssembly().assembly()
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
