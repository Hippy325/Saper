//
//  Algoritm.swift
//  App
//
//  Created by User on 16.03.2023.
//

import Foundation

final class Algoritm {
	private var number: Int = 0
	private let matrix: [State]
	private let matrixPosition: MatrixPosition

	init(matrix: [State], posotion: Int) {
		self.matrix = matrix
		self.matrixPosition = MatrixPosition(position: posotion)
	}
	func main() -> Int {
		if matrixPosition.column == 0 {
			leftSide()
		}

		if matrixPosition.column == 6 {
			rightSide()
		}

		if matrixPosition.column > 0 && matrixPosition.column < 6 {
			centerSide()
		}
		return number
	}

	private func centerSide() {
		check(matrixPosition: matrixPosition.moveLeft())
		check(matrixPosition: matrixPosition.moveRight())
		if matrixPosition.row == 0 {
			check(matrixPosition: matrixPosition.moveDown())
			check(matrixPosition: matrixPosition.moveLeftDown())
			check(matrixPosition: matrixPosition.moveRightDown())
		} else {
			if matrixPosition.row == 10 {
				check(matrixPosition: matrixPosition.moveUp())
				check(matrixPosition: matrixPosition.moveLeftUp())
				check(matrixPosition: matrixPosition.moveRightUp())
			} else {
				check(matrixPosition: matrixPosition.moveUp())
				check(matrixPosition: matrixPosition.moveLeftUp())
				check(matrixPosition: matrixPosition.moveRightUp())
				check(matrixPosition: matrixPosition.moveDown())
				check(matrixPosition: matrixPosition.moveLeftDown())
				check(matrixPosition: matrixPosition.moveRightDown())
			}
		}
	}

	private func leftSide() {
		check(matrixPosition: matrixPosition.moveRight())
		if matrixPosition.row == 0 {
			check(matrixPosition: matrixPosition.moveDown())
			check(matrixPosition: matrixPosition.moveRightDown())
		} else {
			if matrixPosition.row == 10 {
				check(matrixPosition: matrixPosition.moveUp())
				check(matrixPosition: matrixPosition.moveRightUp())
			} else {
				check(matrixPosition: matrixPosition.moveDown())
				check(matrixPosition: matrixPosition.moveRightDown())
				check(matrixPosition: matrixPosition.moveUp())
				check(matrixPosition: matrixPosition.moveRightUp())
			}
		}
	}

	private func rightSide() {
		check(matrixPosition: matrixPosition.moveLeft())
		if matrixPosition.row == 0 {
			check(matrixPosition: matrixPosition.moveDown())
			check(matrixPosition: matrixPosition.moveLeftDown())
		} else {
			if matrixPosition.row == 10 {
				check(matrixPosition: matrixPosition.moveLeftUp())
				check(matrixPosition: matrixPosition.moveUp())
			} else {
				check(matrixPosition: matrixPosition.moveDown())
				check(matrixPosition: matrixPosition.moveLeftDown())
				check(matrixPosition: matrixPosition.moveLeftUp())
				check(matrixPosition: matrixPosition.moveUp())
			}
		}
	}

	private func check(matrixPosition: MatrixPosition) {
		if matrix[matrixPosition.getPosition()] == .bomb {
			number += 1
		}
	}
}

struct MatrixPosition: Equatable, Hashable {
	let row: Int
	let column: Int

	private init (row: Int, column: Int) {
		self.row = row
		self.column = column
	}

	init(position: Int) {
		self.column = position / 11
		self.row = position % 11
	}

	private func move(column columnOffset: Int) -> MatrixPosition {
		MatrixPosition(row: row, column: column + columnOffset)
	}

	private func move(row rowOffset: Int) -> MatrixPosition {
		MatrixPosition(row: row + rowOffset, column: column)
	}

	func getPosition() -> Int {
		return column * 11 + row
	}
}

extension MatrixPosition {
	func moveUp() -> MatrixPosition {
		move(row: -1)
	}

	func moveDown() -> MatrixPosition {
		move(row: 1)
	}

	func moveLeft() -> MatrixPosition {
		move(column: -1)
	}

	func moveRight() -> MatrixPosition {
		move(column: 1)
	}

	func moveLeftUp() -> MatrixPosition {
		moveLeft().moveUp()
	}

	func moveLeftDown() -> MatrixPosition {
		moveLeft().moveDown()
	}

	func moveRightUp() -> MatrixPosition {
		moveRight().moveUp()
	}

	func moveRightDown() -> MatrixPosition {
		moveRight().moveDown()
	}
}

// protocol Default {
//	static var `default`: Self { get }
// }
//
// struct MatrixSnapshot<T: Default>: Sequence {
//
//	init(rowCapacity: UInt, columnCapacity: UInt) {
//		self.rowCapacity = rowCapacity
//		self.columnCapacity = columnCapacity
//	}
//
//	var matrixValues: [MatrixPosition: T] = [:]
//
//	let rowCapacity: UInt
//	let columnCapacity: UInt
//
//	subscript(position: MatrixPosition) -> T {
//		get {
//			matrixValues[position] ?? .default
//		}
//		set(newValue) {
//			guard position.row <= rowCapacity, position.column <= columnCapacity else { return }
//			matrixValues[position] = newValue
//		}
//	}
//
//	var startPosition: MatrixPosition {
//		MatrixPosition(row: 0, column: 0)
//	}
//
//	func makeIterator() -> some IteratorProtocol {
//		var position: MatrixPosition? = startPosition
//		return AnyIterator<T> {
//			guard let unwrappedPosition = position else { return nil }
//			let value = self[unwrappedPosition]
//			position = increment(position: unwrappedPosition)
//			return value
//		}
//	}
//
//	func increment(position: MatrixPosition) -> MatrixPosition? {
//		if position.column == columnCapacity, position.row == rowCapacity { return nil }
//
//		if position.row == rowCapacity {
//			return MatrixPosition(row: 0, column: position.column + 1)
//		} else {
//			return MatrixPosition(row: position.row + 1, column: position.column)
//		}
//	}
// }
