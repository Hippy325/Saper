//
//  Matrix.swift
//  Saper
//
//  Created by User on 13.10.2022.
//

import Foundation

protocol IMatrix {
	var matrixOptions: MatrixOptions { get }

	func createNewField(startPosition: Int)
	func getField() -> [Int?]
}

enum State {
	case bomb
	case number
}

final class Matrix: IMatrix {
	var matrixOptions: MatrixOptions
	private var mainMatrix: [Int?] = []
	private lazy var algorithmNumbers = AlgorithmNumbers(
		countCollumn: matrixOptions.countCollumn,
		countRow: matrixOptions.countRow
	)

	init(matrixOptions: MatrixOptions) {
		self.matrixOptions = matrixOptions
	}

	private func getStateMatrix(startPosition: Int) -> [State] {
		var matrix: [State] = []
		var countB = matrixOptions.countBomb
		var countC = matrixOptions.countCell

		for position in 0...matrixOptions.countCell {
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

	func createNewField(startPosition: Int) {
		var matematicMatrix: [Int?] = []
		let stateMatrix: [State] = getStateMatrix(startPosition: startPosition)
		for index in 0...(matrixOptions.countCell - 1) {
			let number = numberForMatrix(position: index, matrix: stateMatrix)
			matematicMatrix.append(number)
		}
		mainMatrix = matematicMatrix
	}

	func getField() -> [Int?] {
		return mainMatrix
	}
}

extension Matrix {
	private func numberForMatrix(position: Int, matrix: [State]) -> Int? {
		if matrix[position] == .bomb {
			return nil
		}
		var number = 0
		number = algorithmNumbers.main(position: position, matrix: matrix)
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
