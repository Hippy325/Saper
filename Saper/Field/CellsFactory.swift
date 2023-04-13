//
//	CellsFactory.swift
//  Saper
//
//  Created by User on 02.08.2022.
//

import Foundation
import UIKit

protocol ICellsFactory {
	func make(countCell: Int) -> [UIButton]
}

final class CellsFactory: ICellsFactory {

	private let liaison: ILiaisonCells

	init(liaison: ILiaisonCells) {
		self.liaison = liaison
	}

	func make(countCell: Int) -> [UIButton] {
		liaison.clearCells()
		var cells: [Cell] = []
		for iter in 0...countCell - 1 {
			let cell = Cell(tag: iter, liaison: liaison)
			cells.append(cell)
		}
		return cells
	}
}
