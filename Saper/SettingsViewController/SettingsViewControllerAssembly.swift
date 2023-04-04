//
//  SettingsViewControllerAssembly.swift
//  App
//
//  Created by User on 31.03.2023.
//

import Foundation
import UIKit

protocol ISettingsViewControllerAssembly {
	func assembly(screen: IGameView) -> UIViewController
}

final class SettingsViewControllerAssembly: ISettingsViewControllerAssembly {

	func assembly(screen: IGameView) -> UIViewController {
		let router = SettingsRouter()
		let presenter = SettingsViewControllerPresenter(router: router, playingScreen: screen)
		let settingsViewController = SettingsViewController(presenter: presenter)
		presenter.view = settingsViewController
		router.viewController = settingsViewController
		return settingsViewController
	}
}
