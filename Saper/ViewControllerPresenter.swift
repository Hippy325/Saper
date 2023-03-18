//
//  ViewControllerPresenter.swift
//  Saper
//
//  Created by User on 03.03.2023.
//

import Foundation

protocol IViewControllerPresenter {
	func setCountBombAndCell(cell: Int, bomb: Int)
	func newField()
	func newMatrix()
	func changeType() -> Bool
}

protocol IPresenterView: AnyObject {
	func updateTime(time: Int)
	func updateCounterBomb(count: Int)
}

final class ViewControllerPresenter {
	private var countBomb: Int = 0
	private var countCell: Int = 0
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
	func setCountBombAndCell(cell: Int, bomb: Int) {
		self.countBomb = bomb
		self.countCell = cell
	}

	func getCountCellAndBomb() -> (Int, Int) {
		return (countCell, countBomb)
	}

	func newField() {
		liaison.newField()
		counterBomb = countBomb
	}

	func newMatrix() {
		liaison.newMatrix(countCell: countCell, countBomb: countBomb)
	}

	func changeType() -> Bool {
		return liaison.changePress()
	}

	func getCurrentCountBomb() -> Int {
		return counterBomb
	}
}

extension ViewControllerPresenter: ILiaisonPresenter {
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
