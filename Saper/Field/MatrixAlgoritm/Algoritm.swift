//
//  Algoritm.swift
//  App
//
//  Created by User on 16.03.2023.
//

import Foundation
import SwiftUI

@_functionBuilder final class MatrixPositionResultBuilder {
	static func buildBlock(_ components: [MatrixPosition]...) -> [MatrixPosition] {
		return components.flatMap { $0 }
	}

	static func buildExpression(_ expression: MatrixPosition) -> [MatrixPosition] {
		[expression]
	}

	static func buildExpression(_ expression: [MatrixPosition]) -> [MatrixPosition] {
		expression
	}

	static func buildOptional(_ components: [MatrixPosition]?) -> [MatrixPosition] {
		components ?? []
	}

	static func buildIf(_ content: [MatrixPosition]?) -> [MatrixPosition] {
		content ?? []
	}

	static func buildEither(first: [MatrixPosition]) -> [MatrixPosition] {
		first
	}

	static func buildEither(second: [MatrixPosition]) -> [MatrixPosition] {
		second
	}
}

extension Algoritm {
	func checkResultBuilder(@MatrixPositionResultBuilder positions: () -> [MatrixPosition]) {
		positions().forEach {
			check(matrixPosition: $0)
		}
	}
}

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
		checkResultBuilder {
			matrixPosition.moveLeft()
			matrixPosition.moveRight()
			if matrixPosition.row == 0 {
				matrixPosition.moveLeftDown()
				matrixPosition.moveRightDown()
				matrixPosition.moveDown()
			} else {
				if matrixPosition.row == 10 {
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
