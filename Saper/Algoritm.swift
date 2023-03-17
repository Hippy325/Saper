//
//  Algoritm.swift
//  App
//
//  Created by User on 16.03.2023.
//
// swiftlint:disable cyclomatic_complexity

import Foundation

final class Algoritm {
	private var number: Int = 0
	func main(position: Int, matrix: [State]) -> Int {
		if position < 11 {
			leftSide(position: position, matrix: matrix)
		}

		if position > 65 {
			rightSide(position: position, matrix: matrix)
		}

		if position <= 65 && position >= 11 {
			centerSide(position: position, matrix: matrix)
		}
		return number
	}

	private func centerSide(position: Int, matrix: [State]) {
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
	}

	private func leftSide(position: Int, matrix: [State]) {
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
	}

	private func rightSide(position: Int, matrix: [State]) {
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
	}
}
