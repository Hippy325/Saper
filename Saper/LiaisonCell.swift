//
//  LiaisonCell.swift
//  Saper
//
//  Created by User on 03.03.2023.
//

import Foundation
protocol ILiaisonPresenter: AnyObject {
	func startTimer()
	func stopTimer(isWin: Bool)
	func counterBombDec()
	func counterBombInc()
}

protocol ILiaison: AnyObject {
	func appendCell(cell: Cell)
	func notification(position: Int)
}

protocol IliaisonMatrix {
	func newMatrix(countCell: Int, countBomb: Int)
	func newField()
	func getField() -> [Int?]
	func changePress() -> Bool
}

final class Liaison: ILiaison {
	private enum TypePress {
		case flag
		case opened
		case unopened
	}

	private var arrayCell: [Cell] = []
	private var arrayTap: [TypePress] = []
	private var matrix: IMatrix?
	private weak var presenter: ILiaisonPresenter?
	private var countCellAndBomb: (Int, Int)?
	private var isNew: Bool = true
	private var countPress: Int = 0
	private var typePress: Bool = false

	func appendCell(cell: Cell) {
		arrayCell.append(cell)
		arrayTap.append(.unopened)
	}

	func notification(position: Int) {
		if isNew {
			matrix?.createNewMatrix(startPosition: position)
			presenter?.startTimer()
		}

		if !typePress || isNew {
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
		isNew = false
	}

	func setPresenter(presenter: ILiaisonPresenter) {
		self.presenter = presenter
	}

	private func pressOpen(position: Int) {
		countPress += 1
		let state = matrix?.getMatrix()[position]
		if state == nil {
			presenter?.stopTimer(isWin: false)
			arrayCell.forEach { (cell) in
				cell.layer.borderWidth = 0
				cell.isEnabled = false
			}
		}
		arrayCell[position].actionChange(state: state)
		guard let countCellAndBomb = countCellAndBomb else { return }
		if countPress == (countCellAndBomb.0 - countCellAndBomb.1) {
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
}

extension Liaison: IliaisonMatrix {
	func newField() {
		isNew = true
		countPress = 0
		presenter?.stopTimer(isWin: false)

		for index in 0...arrayTap.count - 1 {
			arrayTap[index] = .unopened
		}

		arrayCell.forEach { (cell) in
			cell.initalState()
			cell.deleteFlag()
		}
	}

	func getField() -> [Int?] {
		guard let matrix = matrix else { return [] }
		return matrix.getMatrix()
	}

	func newMatrix(countCell: Int, countBomb: Int) {
		self.matrix = Matrix(countBomb: countBomb, countCell: countCell)
		self.countCellAndBomb = (countCell, countBomb)
	}

	func changePress() -> Bool {
		self.typePress = !self.typePress
		return typePress
	}
}
