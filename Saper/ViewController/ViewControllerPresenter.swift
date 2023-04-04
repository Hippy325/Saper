//
//  ViewControllerPresenter.swift
//  Saper
//
//  Created by User on 03.03.2023.
//

import Foundation

protocol IViewControllerPresenter: ISetPlayingOptions {
	func newField()
	func newMatrix(cell: Int, bomb: Int)
	func changeType() -> Bool
}

protocol IPresenterView: AnyObject {
	func updateTime(time: Int)
	func updateCounterBomb(count: Int)
	func updatePlaingView(countCell: Int)
}

final class ViewControllerPresenter {
	private var counterBomb: Int = 10 {
		didSet {
			view?.updateCounterBomb(count: counterBomb)
		}
	}
	private let liaison: IliaisonMatrix
	weak var view: IPresenterView?
	private var timer: Timer?

	init(liaison: IliaisonMatrix) {
		self.liaison = liaison
	}
}

extension ViewControllerPresenter: IViewControllerPresenter {
	func newField() {
		liaison.newField()
	}

	func newMatrix(cell: Int, bomb: Int) {
		liaison.newMatrix(countCell: cell, countBomb: bomb)
		view?.updatePlaingView(countCell: cell)
	}

	func changeType() -> Bool {
		return liaison.changePress()
	}

	func getCurrentCountBomb() -> Int {
		return counterBomb
	}
}

extension ViewControllerPresenter: ILiaisonPresenter {
	func countBombStart(count: Int) {
		counterBomb = count
	}

	func counterBombDec() {
		counterBomb -= 1
	}

	func counterBombInc() {
		counterBomb += 1
	}

	func stopTimer(isWin: Bool) {
		guard let timer = timer else { return }
		timer.invalidate()
		if isWin {
			counterBomb = 0
		}
	}

	func startTimer() {
		var seconds = 1
		view?.updateTime(time: 0)

		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
			self.view?.updateTime(time: seconds)
			seconds += 1
		}
	}
}

extension ViewControllerPresenter: ISetPlayingOptions {
	func updateSettings(countCell: Int, countBomb: Int, row: Int, collumn: Int) {}
}
