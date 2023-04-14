//
//  AlgoritmOpen.swift
//  App
//
//  Created by User on 16.03.2023.
//

import Foundation

final class AlgoritmOpen {

	private let countCollumn: Int
	private let countRow: Int
	private let position: Int

	init(countCollumn: Int, countRow: Int, position: Int) {
		self.countCollumn = countCollumn
		self.countRow = countRow
		self.position = position
	}

	func open(complition: (_ position: Int) -> Void) {
		let matrixPosition = getMatrixPosition(position: position)
		if matrixPosition.column == 0 {
			leftSide(matrixPosition: matrixPosition, complition: complition)
		}
		if matrixPosition.column == countCollumn - 1 {
			rightSide(matrixPosition: matrixPosition, complition: complition)
		}
		if matrixPosition.column > 0 && matrixPosition.column < countCollumn - 1 {
			centerSide(matrixPosition: matrixPosition, complition: complition)
		}
	}

	private func centerSide(matrixPosition: MatrixPosition, complition: (_ position: Int) -> Void) {
		complition(getPosition(matrixPosition.moveLeft()))
		complition(getPosition(matrixPosition.moveRight()))
		if matrixPosition.row == 0 {
			complition(getPosition(matrixPosition.moveDown()))
			complition(getPosition(matrixPosition.moveLeftDown()))
			complition(getPosition(matrixPosition.moveRightDown()))
		} else {
			if matrixPosition.row == countRow - 1 {
				complition(getPosition(matrixPosition.moveUp()))
				complition(getPosition(matrixPosition.moveLeftUp()))
				complition(getPosition(matrixPosition.moveRightUp()))
			} else {
				complition(getPosition(matrixPosition.moveUp()))
				complition(getPosition(matrixPosition.moveLeftUp()))
				complition(getPosition(matrixPosition.moveRightUp()))
				complition(getPosition(matrixPosition.moveDown()))
				complition(getPosition(matrixPosition.moveLeftDown()))
				complition(getPosition(matrixPosition.moveRightDown()))
			}
		}
	}

	private func leftSide(matrixPosition: MatrixPosition, complition: (_ position: Int) -> Void) {
		complition(getPosition(matrixPosition.moveRight()))
		switch matrixPosition.row {
		case 0:
			complition(getPosition(matrixPosition.moveDown()))
			complition(getPosition(matrixPosition.moveRightDown()))
		case countRow - 1:
			complition(getPosition(matrixPosition.moveUp()))
			complition(getPosition(matrixPosition.moveRightUp()))
		default:
			complition(getPosition(matrixPosition.moveUp()))
			complition(getPosition(matrixPosition.moveRightUp()))
			complition(getPosition(matrixPosition.moveDown()))
			complition(getPosition(matrixPosition.moveRightDown()))
		}
	}

	private func rightSide(matrixPosition: MatrixPosition, complition: (_ position: Int) -> Void) {
		complition(getPosition(matrixPosition.moveLeft()))
		switch matrixPosition.row {
		case 0:
			complition(getPosition(matrixPosition.moveDown()))
			complition(getPosition(matrixPosition.moveLeftDown()))
		case countRow - 1:
			complition(getPosition(matrixPosition.moveUp()))
			complition(getPosition(matrixPosition.moveLeftUp()))
		default:
			complition(getPosition(matrixPosition.moveDown()))
			complition(getPosition(matrixPosition.moveLeftDown()))
			complition(getPosition(matrixPosition.moveUp()))
			complition(getPosition(matrixPosition.moveLeftUp()))
		}
	}

	private func getPosition(_ matrixPosition: MatrixPosition) -> Int {
		return matrixPosition.column * countRow + matrixPosition.row
	}

	private func getMatrixPosition(position: Int) -> MatrixPosition {
		return MatrixPosition(row: position % countRow, column: position / countRow)
	}
}
