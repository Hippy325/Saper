//
//  ViewControllerPresenter.swift
//  Saper
//
//  Created by User on 03.03.2023.
//

import Foundation

protocol IGamePresenter {
	func newField()
	func newMatrix()
	func changeType() -> Bool
	func goToSettingsScreen()
}

protocol IGameView: AnyObject {
	func updateTime(time: String)
	func updateCounterBomb(bomb: String)
	func updatePlaingView(countCell: Int, countCollumn: Int, countRow: Int)
}

final class GamePresenter {
	private var counterBomb: Int = 10 {
		didSet {
			view?.updateCounterBomb(bomb: transformCountBombToString(count: counterBomb))
		}
	}

	private let liaison: ILiaisonMatrix
	private let router: IGameRouter

	weak var view: IGameView?
	private var timer: Timer?
	private var fieldParametrs = MatrixOptions(countCell: 77, countBomb: 10, countCollumn: 7, countRow: 11)

	init(liaison: ILiaisonMatrix, router: IGameRouter) {
		self.liaison = liaison
		self.router = router
	}

	private func transformCountBombToString(count: Int) -> String {
		var text = "\(count)"
		switch count {
		case 10...99:
			text = "0\(count)"
		case 0...9:
			text = "00\(count)"
		default:
			text = "\(count)"
		}

		return text
	}

	private func transformTimeToString(time: Int) -> String {
		var timeString = "\(time)"
		switch time {
		case 10...99:
			timeString = "0\(time)"
		case 0...9:
			timeString = "00\(time)"
		default:
			timeString = "\(time)"
		}

		return timeString
	}

}

extension GamePresenter: IGamePresenter {

	func newField() {
		liaison.newField()
		view?.updateTime(time: transformTimeToString(time: 0))
	}

	func newMatrix() {
		liaison.newMatrix(matrixOptions: fieldParametrs)
		view?.updatePlaingView(
			countCell: fieldParametrs.countCell,
			countCollumn: fieldParametrs.countCollumn,
			countRow: fieldParametrs.countRow
		)
	}

	func changeType() -> Bool {
		return liaison.changePress()
	}

	func goToSettingsScreen() {
		router.pushSettingsScreen(listner: self)
	}
}

extension GamePresenter: ILiaisonListner {
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
		view?.updateTime(time: transformTimeToString(time: 0))

		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			self.view?.updateTime(time: self.transformTimeToString(time: seconds))
			seconds += 1
		}
	}
}

extension GamePresenter: ISetPlayingOptions {
	func updateSettings(fieldParametrs: MatrixOptions) {
		self.fieldParametrs = fieldParametrs
		newMatrix()
	}
}
