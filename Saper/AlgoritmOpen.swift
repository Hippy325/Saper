//
//  AlgoritmOpen.swift
//  App
//
//  Created by User on 16.03.2023.
//

import Foundation

final class AlgoritmOpen {

	func open(startPosition: Int, complition: (_ position: Int) -> Void) {
		if startPosition < 11 {
			leftSide(startPosition: startPosition, complition: complition)
		}
		if startPosition > 65 {
			rightSide(startPosition: startPosition, complition: complition)
		}
		if startPosition <= 65 && startPosition >= 11 {
			centerSide(startPosition: startPosition, complition: complition)
		}
	}

	private func centerSide(startPosition: Int, complition: (_ position: Int) -> Void) {
		complition(startPosition - 11)
		complition(startPosition + 11)
		if startPosition % 11 == 0 {
			complition(startPosition + 1)
			complition(startPosition - 10)
			complition(startPosition + 12)
		} else {
			if startPosition == 65 || startPosition == 54 || startPosition == 43 || startPosition == 32 || startPosition == 21 {
				complition(startPosition - 1)
				complition(startPosition + 10)
				complition(startPosition - 12)
			} else {
				complition(startPosition - 1)
				complition(startPosition + 10)
				complition(startPosition - 12)
				complition(startPosition + 1)
				complition(startPosition - 10)
				complition(startPosition + 12)
			}
		}
	}

	private func leftSide(startPosition: Int, complition: (_ position: Int) -> Void) {
		complition(startPosition + 11)
		switch startPosition {
		case 0:
			complition(startPosition + 1)
			complition(startPosition + 12)
		case 10:
			complition(startPosition - 1)
			complition(startPosition + 10)
		default:
			complition(startPosition + 1)
			complition(startPosition + 12)
			complition(startPosition - 1)
			complition(startPosition + 10)
		}
	}

	private func rightSide(startPosition: Int, complition: (_ position: Int) -> Void) {
		complition(startPosition - 11)
		switch startPosition {
		case 66:
			complition(startPosition + 1)
			complition(startPosition - 10)
		case 76:
			complition(startPosition - 1)
			complition(startPosition - 12)
		default:
			complition(startPosition + 1)
			complition(startPosition - 10)
			complition(startPosition - 1)
			complition(startPosition - 12)
		}
	}
}
