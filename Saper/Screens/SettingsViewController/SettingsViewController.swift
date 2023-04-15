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
		let complexity = UISegmentedControl(items: ["Easy", "Medium", "Hard", "Expert"])
		let countBombSlider = UISlider()
		let countCellSlider = UISlider()
		let showCountCell = UILabel()
		let showCountBomb = UILabel()
		let cellDescription = UILabel()
		let bombDescription = UILabel()
	}
	private let subviews = Subviews()
	private let presenter: ISettingsPresenter

	init(presenter: ISettingsPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .gray
		setupSubviews()
		setupConstraints()
	}
}

private extension SettingsViewController {
	func setupSubviews() {
		view.addSubview(subviews.closeSettings)
		subviews.closeSettings.backgroundColor = .darkGray
		subviews.closeSettings.layer.addSublayer(Xmark().xmark())
		subviews.closeSettings.layer.cornerRadius = 10
		subviews.closeSettings.translatesAutoresizingMaskIntoConstraints = false
		subviews.closeSettings.addTarget(self, action: #selector(closeSettingsScreen), for: .touchUpInside)

		view.addSubview(subviews.difficultyLevels)
		subviews.difficultyLevels.backgroundColor = .clear
		subviews.difficultyLevels.text = "Сложность"
		subviews.difficultyLevels.font = UIFont.systemFont(ofSize: 45)
		subviews.difficultyLevels.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(subviews.complexity)
		subviews.complexity.translatesAutoresizingMaskIntoConstraints = false
		subviews.complexity.backgroundColor = .clear
		subviews.complexity.setTitleTextAttributes(
			[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)],
			for: .normal
		)
		subviews.complexity.backgroundColor = .darkGray
		subviews.complexity.selectedSegmentIndex = 0
		setActionComplexity()
		counterSubviews()
		updateData()
	}

	private func setActionComplexity() {
		let actionEasy = UIAction(title: "Easy") { (_) in
			self.presenter.set(complexityVariant: .easy)
		}
		subviews.complexity.setAction(actionEasy, forSegmentAt: 0)

		let actionMedium = UIAction(title: "Medium") { (_) in
			self.presenter.set(complexityVariant: .medium)
		}
		subviews.complexity.setAction(actionMedium, forSegmentAt: 1)

		let actionHard = UIAction(title: "Hard") { (_) in
			self.presenter.set(complexityVariant: .hard)
		}
		subviews.complexity.setAction(actionHard, forSegmentAt: 2)

		let actionExpert = UIAction(title: "Expert") { (_) in
			self.presenter.set(complexityVariant: .expert)
		}
		subviews.complexity.setAction(actionExpert, forSegmentAt: 3)
		updateData()
	}

	private func counterSubviews() {
		view.addSubview(subviews.countCellSlider)
		subviews.countCellSlider.maximumValue = Float(presenter.cellCountRange.upperBound)
		subviews.countCellSlider.minimumValue = Float(presenter.cellCountRange.lowerBound)
		subviews.countCellSlider.thumbTintColor = .black
		subviews.countCellSlider.tintColor = .black
		subviews.countCellSlider.maximumTrackTintColor = .blue
		subviews.countCellSlider.translatesAutoresizingMaskIntoConstraints = false
		subviews.countCellSlider.addTarget(self, action: #selector(updateCellCount), for: .valueChanged)

		view.addSubview(subviews.countBombSlider)
		subviews.countBombSlider.maximumValue =	Float(presenter.bombCountRange.upperBound)
		subviews.countBombSlider.minimumValue = Float(presenter.bombCountRange.lowerBound)
		subviews.countBombSlider.thumbTintColor = .black
		subviews.countBombSlider.tintColor = .black
		subviews.countBombSlider.maximumTrackTintColor = .red
		subviews.countBombSlider.translatesAutoresizingMaskIntoConstraints = false
		subviews.countBombSlider.addTarget(self, action: #selector(updateBombCount), for: .valueChanged)

		view.addSubview(subviews.cellDescription)
		subviews.cellDescription.backgroundColor = .clear
		subviews.cellDescription.text = "размер"
		subviews.cellDescription.font = UIFont.systemFont(ofSize: 20)
		subviews.cellDescription.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(subviews.bombDescription)
		subviews.bombDescription.backgroundColor = .clear
		subviews.bombDescription.text = "бомб"
		subviews.bombDescription.font = UIFont.systemFont(ofSize: 20)
		subviews.bombDescription.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(subviews.showCountCell)
		subviews.showCountCell.backgroundColor = .clear
		subviews.showCountCell.font = UIFont.systemFont(ofSize: 20)
		subviews.showCountCell.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(subviews.showCountBomb)
		subviews.showCountBomb.backgroundColor = .clear
		subviews.showCountBomb.font = UIFont.systemFont(ofSize: 20)
		subviews.showCountBomb.translatesAutoresizingMaskIntoConstraints = false
	}

	@objc private func updateCellCount() {
		subviews.showCountCell.text =
			"\(AlgoritmFieldParametrs.countCell(properties: Int(subviews.countCellSlider.value)))"
		presenter.updateCurrentComplexity(cell: Int(subviews.countCellSlider.value))
	}
	@objc private func updateBombCount() {
		subviews.showCountBomb.text = "\(Int(subviews.countBombSlider.value))"
		presenter.updateCurrentComplexity(bomb: Int(subviews.countBombSlider.value))
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			subviews.closeSettings.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			subviews.closeSettings.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
			subviews.closeSettings.heightAnchor.constraint(equalToConstant: 55),
			subviews.closeSettings.widthAnchor.constraint(equalToConstant: 55)
		])

		NSLayoutConstraint.activate([
			subviews.difficultyLevels.topAnchor.constraint(equalTo: subviews.closeSettings.bottomAnchor, constant: 10),
			subviews.difficultyLevels.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			subviews.difficultyLevels.heightAnchor.constraint(equalToConstant: 50)
		])

		NSLayoutConstraint.activate([
			subviews.complexity.topAnchor.constraint(equalTo: subviews.difficultyLevels.bottomAnchor, constant: 10),
			subviews.complexity.heightAnchor.constraint(equalToConstant: 50),
			subviews.complexity.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
			subviews.complexity.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30)
		])

		NSLayoutConstraint.activate([
			subviews.countCellSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			subviews.countCellSlider.topAnchor.constraint(equalTo: subviews.complexity.bottomAnchor, constant: 20),
			subviews.countCellSlider.widthAnchor.constraint(equalToConstant: 200)
		])

		NSLayoutConstraint.activate([
			subviews.countBombSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			subviews.countBombSlider.topAnchor.constraint(equalTo: subviews.countCellSlider.bottomAnchor, constant: 15),
			subviews.countBombSlider.widthAnchor.constraint(equalToConstant: 200)
		])

		NSLayoutConstraint.activate([
			subviews.cellDescription.topAnchor.constraint(equalTo: subviews.complexity.bottomAnchor, constant: 10),
			subviews.cellDescription.rightAnchor.constraint(equalTo: subviews.countCellSlider.leftAnchor, constant: -10),
			subviews.cellDescription.heightAnchor.constraint(equalToConstant: 50)
		])

		NSLayoutConstraint.activate([
			subviews.bombDescription.topAnchor.constraint(equalTo: subviews.countCellSlider.bottomAnchor, constant: 5),
			subviews.bombDescription.rightAnchor.constraint(equalTo: subviews.countBombSlider.leftAnchor, constant: -10),
			subviews.bombDescription.heightAnchor.constraint(equalToConstant: 50)
		])

		NSLayoutConstraint.activate([
			subviews.showCountCell.topAnchor.constraint(equalTo: subviews.complexity.bottomAnchor, constant: 10),
			subviews.showCountCell.leftAnchor.constraint(equalTo: subviews.countCellSlider.rightAnchor, constant: 10),
			subviews.showCountCell.heightAnchor.constraint(equalToConstant: 50)
		])

		NSLayoutConstraint.activate([
			subviews.showCountBomb.topAnchor.constraint(equalTo: subviews.countCellSlider.bottomAnchor, constant: 5),
			subviews.showCountBomb.leftAnchor.constraint(equalTo: subviews.countBombSlider.rightAnchor, constant: 10),
			subviews.showCountBomb.heightAnchor.constraint(equalToConstant: 50)
		])
	}

	@objc func closeSettingsScreen() {
		presenter.backToPlayingScreen()
	}
}

extension SettingsViewController: ISettingsView {
	func updateData() {
		subviews.countCellSlider.setValue(Float(presenter.currentComplexity.cellCount), animated: true)
		subviews.countBombSlider.setValue(Float(presenter.currentComplexity.bombCount), animated: true)
		subviews.showCountBomb.text = "\(presenter.currentComplexity.bombCount)"
		subviews.showCountCell.text =
			"\(AlgoritmFieldParametrs.countCell(properties: presenter.currentComplexity.cellCount))"
	}
}
