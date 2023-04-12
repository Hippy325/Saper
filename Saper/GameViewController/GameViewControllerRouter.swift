//
//  ViewControllerRouter.swift
//  App
//
//  Created by User on 31.03.2023.
//

import Foundation
import UIKit

protocol IGameViewControllerRouter {
	func pushSettingsScreen(listner: ISetPlayingOptions)
}

final class GameViewControllerRouter {
	private let settingsViewController: ISettingsViewControllerAssembly
	var viewController: UIViewController?

	init(settingsViewController: ISettingsViewControllerAssembly) {
		self.settingsViewController = settingsViewController
	}
}

extension GameViewControllerRouter: IGameViewControllerRouter {
	func pushSettingsScreen(listner: ISetPlayingOptions) {
		guard let viewController = viewController else { return }
		viewController.present(settingsViewController.assembly(listner: listner), animated: true)
	}
}
