//
//  SettingsViewControllerAssembly.swift
//  App
//
//  Created by User on 31.03.2023.
//

import Foundation
import UIKit

protocol ISettingsViewControllerAssembly {
	func assembly(listner: ISetPlayingOptions) -> UIViewController
}

final class SettingsViewControllerAssembly: ISettingsViewControllerAssembly {

	func assembly(listner: ISetPlayingOptions) -> UIViewController {
		let router = SettingsRouter()
		let presenter = SettingsPresenter(router: router, playingScreen: listner)
		let settingsViewController = SettingsViewController(presenter: presenter)
		presenter.view = settingsViewController
		router.viewController = settingsViewController
		return settingsViewController
	}
}
