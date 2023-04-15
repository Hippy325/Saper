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
			let cell = Cell(tag: iter, liaison: liaison, sizeOfCell: cellSizeOf(countCell: countCell))
			cells.append(cell)
		}
		return cells
	}

	private func cellSizeOf(countCell: Int) -> Cell.SizeOf {
		switch countCell {
		case 0...120:
			return .small
		case 121...250:
			return.average
		case 251...450:
			return .big
		default:
			return.huge
		}
	}
}
