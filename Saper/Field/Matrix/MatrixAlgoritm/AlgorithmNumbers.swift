//
//  Algoritm.swift
//  App
//
//  Created by User on 16.03.2023.
//

import Foundation

final class AlgorithmNumbers {
	private var number: Int = 0
	private var matrix: [State] = []
	private let countCollumn: Int
	private let countRow: Int

	init(countCollumn: Int, countRow: Int) {
		self.countCollumn = countCollumn
		self.countRow = countRow
	}

	func main(position: Int, matrix: [State]) -> Int {
		self.matrix = matrix
		number = 0
		let matrixPosition = getMatrixPosition(position: position)
		if matrixPosition.column == 0 {
			leftSide(matrixPosition: matrixPosition)
		}

		if matrixPosition.column == countCollumn - 1 {
			rightSide(matrixPosition: matrixPosition)
		}

		if matrixPosition.column > 0 && matrixPosition.column < countCollumn - 1 {
			centerSide(matrixPosition: matrixPosition)
		}
		return number
	}

	private func centerSide(matrixPosition: MatrixPosition) {
		checkResultBuilder {
			matrixPosition.moveLeft()
			matrixPosition.moveRight()
			if matrixPosition.row == 0 {
				matrixPosition.moveLeftDown()
				matrixPosition.moveRightDown()
				matrixPosition.moveDown()
			} else {
				if matrixPosition.row == countRow - 1 {
					matrixPosition.moveUp()
					matrixPosition.moveLeftUp()
					matrixPosition.moveRightUp()
				} else {
					matrixPosition.moveUp()
					matrixPosition.moveLeftUp()
					matrixPosition.moveRightUp()
					matrixPosition.moveDown()
					matrixPosition.moveLeftDown()
					matrixPosition.moveRightDown()
				}
			}
		}
	}

	private func leftSide(matrixPosition: MatrixPosition) {
		checkResultBuilder {
			matrixPosition.moveRight()
			if matrixPosition.row == 0 {
				matrixPosition.moveDown()
				matrixPosition.moveRightDown()
			} else {
				if matrixPosition.row == countRow - 1 {
					matrixPosition.moveUp()
					matrixPosition.moveRightUp()
				} else {
					matrixPosition.moveDown()
					matrixPosition.moveRightDown()
					matrixPosition.moveUp()
					matrixPosition.moveRightUp()
				}
			}
		}
	}

	private func rightSide(matrixPosition: MatrixPosition) {
		checkResultBuilder {
			matrixPosition.moveLeft()
			if matrixPosition.row == 0 {
				matrixPosition.moveDown()
				matrixPosition.moveLeftDown()
			} else {
				if matrixPosition.row == countRow - 1 {
					matrixPosition.moveLeftUp()
					matrixPosition.moveUp()
				} else {
					matrixPosition.moveDown()
					matrixPosition.moveLeftDown()
					matrixPosition.moveLeftUp()
					matrixPosition.moveUp()
				}
			}
		}
	}

	private func check(matrixPosition: MatrixPosition) {
		if matrix[getPosition(matrixPosition)] == .bomb {
			number += 1
		}
	}

	private func getPosition(_ matrixPosition: MatrixPosition) -> Int {
		return matrixPosition.column * countRow + matrixPosition.row
	}

	private func getMatrixPosition(position: Int) -> MatrixPosition {
		return MatrixPosition(row: position % countRow, column: position / countRow)
	}
}

extension AlgorithmNumbers {
	func checkResultBuilder(@MatrixPositionResultBuilder positions: () -> [MatrixPosition]) {
		positions().forEach {
			check(matrixPosition: $0)
		}
	}
}
