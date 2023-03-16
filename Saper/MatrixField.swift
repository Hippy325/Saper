//
//  MatrixField.swift
//  Saper
//
//  Created by User on 13.10.2022.
//

import Foundation

protocol IMatrix {
	func createNewMatrix(startPosition: Int)
	func getMatrix() -> [Int?]
}

enum State {
	case bomb
	case number
}

final class Matrix: IMatrix {
	private let countBomb: Int
	private let countCell: Int
	private var mainMatrix: [Int?] = []
	private var start: Int?

	init(countBomb: Int, countCell: Int) {
		self.countBomb = countBomb
		self.countCell = countCell
	}

	private func getStateMatrix(startPosition: Int) -> [State] {
		var matrix: [State] = []
		var countB = countBomb
		var countC = countCell

		for position in 0...countCell {
			if position != startPosition {
				let state: State
				if countB == 0 {
					state = .number
				} else {
					state = random(countC: countC, countB: countB)
				}
				matrix.append(state)
				countC -= 1
				if state == .bomb {
					countB -= 1
				}
			} else {
				matrix.append(.number)
			}
		}
		return matrix
	}

	func createNewMatrix(startPosition: Int) {
		var matematicMatrix: [Int?] = []
		let stateMatrix: [State] = getStateMatrix(startPosition: startPosition)
		var counter = 0
		for _ in 0...(countCell - 1) {
			let number = numberForMatrix(position: counter, matrix: stateMatrix)
			matematicMatrix.append(number)
			counter += 1
		}
		mainMatrix = matematicMatrix
	}

	func getMatrix() -> [Int?] {
		if mainMatrix == [] {
			guard let start = start else { return [] }
			createNewMatrix(startPosition: start)
		}
		return mainMatrix
	}
}

extension Matrix {
	private func numberForMatrix(position: Int, matrix: [State]) -> Int? {
		if matrix[position] == .bomb {
			return nil
		}
		var number = 0
		let algoritm = Algoritm()
		number = algoritm.main(position: position, matrix: matrix)
		return number
	}
	
	private func random(countC: Int, countB: Int) -> State {
		let value = Int.random(in: 0...countC)
		if value <= countB {
			return .bomb
		} else {
			return .number
		}
	}
}
