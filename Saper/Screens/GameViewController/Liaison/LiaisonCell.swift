//
//  LiaisonCell.swift
//  Saper
//
//  Created by User on 03.03.2023.
//

import Foundation

final class Liaison {
	private enum TypePress {
		case flag
		case opened
		case unopened
	}

	private struct GameParametrs {
		var countCellAndBomb: (Int, Int)?
		var isNew: Bool = true
		var countPress: Int = 0
		var isTapFlag: Bool = false
	}

	private var arrayCell: [Cell] = []
	private var arrayTap: [TypePress] = []
	private var matrix = Matrix(countBomb: 10, countCell: 77)
	private weak var presenter: ILiaisonListner?
	private var gameParametrs = GameParametrs()

	func setPresenter(presenter: ILiaisonListner) {
		self.presenter = presenter
	}

	private func pressOpen(position: Int) {
		gameParametrs.countPress += 1
		let state = matrix.getMatrix()[position]
		arrayCell[position].actionChange(state: state)

		if state == nil {
			bombProcessing()
			return
		}
		if state == 0 {
			openAround(position: position)
		}
		gameWinMoment()
	}

	private func bombProcessing() {
		presenter?.stopTimer(isWin: false)
		arrayCell.forEach { (cell) in
			cell.layer.borderWidth = 0
			cell.isEnabled = false
		}
	}

	private func gameWinMoment() {
		guard let countCellAndBomb = gameParametrs.countCellAndBomb else { return }
		if gameParametrs.countPress == (countCellAndBomb.0 - countCellAndBomb.1) {
			arrayCell.forEach { (cell) in
				cell.isEnabled = false
				if cell.backgroundColor == .gray {
					cell.backgroundColor = .green
					cell.flag()
				}
			}
			presenter?.stopTimer(isWin: true)
		}
	}

	private func openAround(position: Int) {
		let algoritmOpen = AlgoritmOpen()
		algoritmOpen.open(startPosition: position) { (position) in
			if !arrayCell[position].clicked() {
				arrayCell[position].actionChange(state: matrix.getMatrix()[position])
				arrayTap[position] = .opened
				gameParametrs.countPress += 1
			}
		}
	}
}

extension Liaison: ILiaisonCells {

	func appendCell(cell: Cell) {
		arrayCell.append(cell)
		arrayTap.append(.unopened)
	}

	func notification(position: Int) {
		if gameParametrs.isNew {
			matrix.createNewMatrix(startPosition: position)
			presenter?.startTimer()
		}

		if !gameParametrs.isTapFlag || gameParametrs.isNew {
			if arrayTap[position] == .unopened {
				arrayTap[position] = .opened
				pressOpen(position: position)
			}
		} else {
			switch arrayTap[position] {
			case .flag:
				presenter?.counterBombInc()
				arrayTap[position] = .unopened
				arrayCell[position].deleteFlag()
			case .unopened:
				presenter?.counterBombDec()
				arrayTap[position] = .flag
				arrayCell[position].flag()
			case .opened: break
			}
		}
		gameParametrs.isNew = false
	}

	func clearCells() {
		arrayCell = []
		arrayTap = []
	}

}

extension Liaison: ILiaisonMatrix {

	func newField() {
		gameParametrs.isNew = true
		gameParametrs.countPress = 0
		presenter?.stopTimer(isWin: false)
		guard let countCellAndBomb = gameParametrs.countCellAndBomb else { return }
		presenter?.countBombStart(count: countCellAndBomb.1)

		for index in 0...arrayTap.count - 1 {
			arrayTap[index] = .unopened
		}

		arrayCell.forEach { (cell) in
			cell.initalState()
			cell.deleteFlag()
		}
	}
	// MARK: - TO DO
	func newMatrix(countCell: Int, countBomb: Int) {
		gameParametrs.isNew = true
		self.matrix = Matrix(countBomb: countBomb, countCell: countCell)
		self.gameParametrs.countCellAndBomb = (countCell, countBomb)
	}

	func changePress() -> Bool {
		self.gameParametrs.isTapFlag = !self.gameParametrs.isTapFlag
		return gameParametrs.isTapFlag
	}

}
