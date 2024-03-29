//
//  SettingsViewControllerPresenter.swift
//  App
//
//  Created by User on 30.03.2023.
//

import Foundation

struct SettingsComplexity {
	var cellCount: Int
	var bombCount: Int
}

enum SettingsCoplexityVariant {
	case easy
	case medium
	case hard
	case expert
}

protocol ISettingsPresenter {
	var cellCountRange: ClosedRange<Int> { get }
	var bombCountRange: ClosedRange<Int> { get }
	var currentComplexity: SettingsComplexity { get }
	func updateCurrentComplexity(bomb: Int)
	func updateCurrentComplexity(cell: Int)

	func set(complexityVariant: SettingsCoplexityVariant)
	func backToPlayingScreen()
}

protocol ISettingsView {
	func updateData()
}

protocol IPlayingScreen {
	func updateSettings(fieldParametrs: MatrixOptions, properties: Int)
	func currentComplexity() -> SettingsComplexity
}

final class SettingsPresenter: ISettingsPresenter {
	var view: ISettingsView?
	private let playingScreen: IPlayingScreen
	private let router: ISettingsRouter

	lazy var currentComplexity = SettingsComplexity(
		cellCount: playingScreen.currentComplexity().cellCount,
		bombCount: playingScreen.currentComplexity().bombCount
	)

	init(router: ISettingsRouter, playingScreen: IPlayingScreen) {
		self.router = router
		self.playingScreen = playingScreen
	}

	func set(complexityVariant: SettingsCoplexityVariant) {
		switch complexityVariant {
		case .easy:
			currentComplexity.cellCount = 77
			currentComplexity.bombCount = 10
		case .medium:
			currentComplexity.cellCount = 133
			currentComplexity.bombCount = 40
		case .hard:
			currentComplexity.cellCount = 188
			currentComplexity.bombCount = 90
		case .expert:
			currentComplexity.cellCount = 231
			currentComplexity.bombCount = 180
		}
		view?.updateData()
	}

	var cellCountRange: ClosedRange<Int> {
		77...231
	}

	var bombCountRange: ClosedRange<Int> {
		10...300
	}

	func backToPlayingScreen() {
		playingScreen.updateSettings(
			fieldParametrs: MatrixOptions(
				countCell: AlgoritmFieldParametrs.countCell(properties: currentComplexity.cellCount),
				countBomb: currentComplexity.bombCount,
				countCollumn: AlgoritmFieldParametrs.countCollumn(properties: currentComplexity.cellCount),
				countRow: AlgoritmFieldParametrs.countRow(properties: currentComplexity.cellCount)),
			properties: currentComplexity.cellCount
		)
		router.backToPlaingScreen()
	}

	func updateCurrentComplexity(bomb: Int) {
		currentComplexity.bombCount = bomb
	}

	func updateCurrentComplexity(cell: Int) {
		currentComplexity.cellCount = cell
	}
}
