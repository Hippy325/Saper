//
//  SettingsViewControllerPresenter.swift
//  App
//
//  Created by User on 30.03.2023.
//

import Foundation

protocol ISettingsViewControllerPresenter {
	func setCountCell(parametrs: Int)
	func setCountBomb(countBomb: Int)
	func backToPlayingScreen()
}

protocol UpdatingViewSettings {
	func updateCountCell(countCell: Int)
	func updateCountBomb(countBomb: Int)
}

protocol IGameView {
	func udatingField(countCell: Int, countBomb: Int, row: Int, collumn: Int)
}

final class SettingsViewControllerPresenter: ISettingsViewControllerPresenter {
	var view: UpdatingViewSettings?
	private let playingScreen: IGameView
	private let router: ISettingsRouter
	private var countCellParametrs: Int = 77 {
		didSet {
			self.view?.updateCountCell(countCell: AlgoritmFieldParametrs.countCell(properties: countCellParametrs))
		}
	}

	private var countBomb: Int = 10 {
		didSet {
			self.view?.updateCountBomb(countBomb: countBomb)
		}
	}

	init(router: ISettingsRouter, playingScreen: IGameView) {
		self.router = router
		self.playingScreen = playingScreen
	}

	func setCountCell(parametrs: Int) {
		countCellParametrs = parametrs
	}

	func setCountBomb(countBomb: Int) {
		self.countBomb = countBomb
	}

	func backToPlayingScreen() {
		router.backToPlaingScreen()
		playingScreen.udatingField(
			countCell: AlgoritmFieldParametrs.countCell(properties: countCellParametrs),
			countBomb: countBomb,
			row: AlgoritmFieldParametrs.countRow(properties: countCellParametrs),
			collumn: AlgoritmFieldParametrs.countCollumn(properties: countCellParametrs)
		)
	}
}
