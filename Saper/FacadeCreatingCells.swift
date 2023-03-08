//
//	FacadeCreatingCells.swift
//  Saper
//
//  Created by User on 02.08.2022.
//

import Foundation
import UIKit

protocol ICreatingCells {
	func getCells(count: Int) -> [UIButton]
}

final class CreatingCells: ICreatingCells {

	private let liaison: ILiaison

	init(liaison: ILiaison) {
		self.liaison = liaison
	}

	func getCells(count: Int) -> [UIButton] {
		var cells: [Cell] = []
		for iter in 0...count - 1 {
			let cell = Cell(tag: iter, liaison: liaison)
			cells.append(cell)
		}
		return cells
	}
}
