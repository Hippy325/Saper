//
//  MatrixField.swift
//  Saper
//
//  Created by User on 13.10.2022.
//
// swiftlint:disable cyclomatic_complexity

import Foundation

protocol IMatrix {
	func createNewMatrix(startPosition: Int)
	func getMatrix() -> [Int?]
}

final class Matrix: IMatrix {
	private enum State {
		case bomb
		case number
	}

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

		if position < 11 {
			number += leftSide(position: position, matrix: matrix)
		}

		if position > 65 {
			number += rightSide(position: position, matrix: matrix)
		}

		if position <= 65 && position >= 11 {
			number += centerSide(position: position, matrix: matrix)
		}
		return number
	}

	private func leftSide(position: Int, matrix: [State]) -> Int {
		var number = 0

		if matrix[position+11] == .bomb {
			number += 1
		}
		if position == 0 {
			if matrix[position+1] == .bomb {
				number += 1
			}

			if matrix[position+12] == .bomb {
				number += 1
			}
		} else {
			if position == 10 {
				if matrix[position-1] == .bomb {
					number += 1
				}

				if matrix[position+10] == .bomb {
					number += 1
				}
			} else {
				if matrix[position-1] == .bomb {
					number += 1
				}

				if matrix[position+10] == .bomb {
					number += 1
				}
				if matrix[position+1] == .bomb {
					number += 1
				}

				if matrix[position+12] == .bomb {
					number += 1
				}
			}
		}
		return number
	}

	private func rightSide(position: Int, matrix: [State]) -> Int {
		var number = 0

		if matrix[position-11] == .bomb {
			number += 1
		}

		if position == 66 {
			if matrix[position+1] == .bomb {
				number += 1
			}

			if matrix[position-10] == .bomb {
				number += 1
			}
		} else {
			if position == 76 {
				if matrix[position-1] == .bomb {
					number += 1
				}

				if matrix[position-12] == .bomb {
					number += 1
				}
			} else {
				if matrix[position-1] == .bomb {
					number += 1
				}

				if matrix[position-10] == .bomb {
					number += 1
				}
				if matrix[position+1] == .bomb {
					number += 1
				}

				if matrix[position-12] == .bomb {
					number += 1
				}
			}
		}

		return number
	}

	private func centerSide(position: Int, matrix: [State]) -> Int {
		var number = 0

		if matrix[position-11] == .bomb {
			number += 1
		}
		if matrix[position+11] == .bomb {
			number += 1
		}

		if position % 11 == 0 {
			if matrix[position+1] == .bomb {
				number += 1
			}
			if matrix[position+12] == .bomb {
				number += 1
			}
			if matrix[position-10] == .bomb {
				number += 1
			}

		} else {
			if position == 65 || position == 54 || position == 43 || position == 32 || position == 21 {
				if matrix[position-1] == .bomb {
					number += 1
				}
				if matrix[position-12] == .bomb {
					number += 1
				}
				if matrix[position+10] == .bomb {
					number += 1
				}

			} else {
				if matrix[position-1] == .bomb {
					number += 1
				}
				if matrix[position+1] == .bomb {
					number += 1
				}
				if matrix[position-10] == .bomb {
					number += 1
				}
				if matrix[position-12] == .bomb {
					number += 1
				}
				if matrix[position+12] == .bomb {
					number += 1
				}
				if matrix[position+10] == .bomb {
					number += 1
				}
			}
		}
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
