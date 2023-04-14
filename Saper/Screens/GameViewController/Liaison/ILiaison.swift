//
//  ILiaison.swift
//  App
//
//  Created by User on 13.04.2023.
//

import Foundation

protocol ILiaisonListner: AnyObject {
	func startTimer()
	func stopTimer(isWin: Bool)
	func counterBombDec()
	func counterBombInc()
	func countBombStart(count: Int)
}

protocol ILiaisonCells: AnyObject {
	func appendCell(cell: Cell)
	func notification(position: Int)
	func clearCells()
}

protocol ILiaisonMatrix {
	func newMatrix(matrixOptions: MatrixOptions)
	func newField()
	func changePress() -> Bool
}
