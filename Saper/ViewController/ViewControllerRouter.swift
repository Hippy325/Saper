//
//  ViewControllerRouter.swift
//  App
//
//  Created by User on 31.03.2023.
//

import Foundation
import UIKit

protocol IViewControllerRouter {
	func pushSettingsScreen(screen: IGameView)
}

final class ViewControllerRouter {
	let settingsViewController: ISettingsViewControllerAssembly
	var viewController: UIViewController?

	init(settingsViewController: ISettingsViewControllerAssembly) {
		self.settingsViewController = settingsViewController
	}
}

extension ViewControllerRouter: IViewControllerRouter {
	func pushSettingsScreen(screen: IGameView) {
		guard let viewController = viewController else { return }
		viewController.present(settingsViewController.assembly(screen: screen), animated: true)
	}
}
