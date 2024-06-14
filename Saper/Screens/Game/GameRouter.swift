//
//  ViewControllerRouter.swift
//  App
//
//  Created by User on 31.03.2023.
//

import Foundation
import UIKit

protocol IGameRouter {
	func pushSettingsScreen(listner: IPlayingScreen)
}

final class GameRouter {
	private let settingsViewControllerAssembly: ISettingsViewControllerAssembly
	var viewController: UIViewController?

	init(settingsViewControllerAssembly: ISettingsViewControllerAssembly) {
		self.settingsViewControllerAssembly = settingsViewControllerAssembly
	}
}

extension GameRouter: IGameRouter {
	func pushSettingsScreen(listner: IPlayingScreen) {
		guard let viewController = viewController else { return }
		viewController.present(settingsViewControllerAssembly.assembly(listner: listner), animated: true)
	}
}
