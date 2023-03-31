//
//  SettingsViewController.swift
//  App
//
//  Created by User on 30.03.2023.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController {
	private struct Subviews {
		let closeSettings = UIButton()
		let difficultyLevels = UILabel()
		let complexity = UISegmentedControl()
	}
	private let subviews = Subviews()
	private let presenter: ISettingsViewControllerPresenter
	private let router: ISettingsRouter

	init(presenter: ISettingsViewControllerPresenter, router: ISettingsRouter) {
		self.presenter = presenter
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .brown
	}
}

private extension SettingsViewController {
	func setupSubviews() {
		view.addSubview(subviews.closeSettings)
		subviews.closeSettings.backgroundColor = .gray

	}
}
