//
//  SettingsViewControllerAssembly.swift
//  App
//
//  Created by User on 31.03.2023.
//

import Foundation
import UIKit

protocol ISettingsViewControllerAssembly {
	func assembly() -> UIViewController
}

final class SettingsViewControllerAssembly: ISettingsViewControllerAssembly {

	func assembly() -> UIViewController {
		let presenter = SettingsViewControllerPresenter()
		let router = SettingsRouter()
		let settingsViewController = SettingsViewController(presenter: presenter, router: router)
		presenter.view = settingsViewController
		router.viewController = settingsViewController
		return settingsViewController
	}
}
