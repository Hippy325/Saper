//
//  MatrixPosition.swift
//  App
//
//  Created by User on 14.04.2023.
//

import Foundation

struct MatrixPosition: Equatable, Hashable {
	let row: Int
	let column: Int

	init (row: Int, column: Int) {
		self.row = row
		self.column = column
	}

	private func move(column columnOffset: Int) -> MatrixPosition {
		MatrixPosition(row: row, column: column + columnOffset)
	}

	private func move(row rowOffset: Int) -> MatrixPosition {
		MatrixPosition(row: row + rowOffset, column: column)
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
