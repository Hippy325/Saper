//
//  FactoryStackView.swift
//  Saper
//
//  Created by User on 07.08.2022.
//

import Foundation
import UIKit

protocol IFactoryStackView {
	func makeHorisontalStack(playingView: UIView, countCell: Int, countCollumn: Int, countRow: Int)
}

final class FactoryStackView: IFactoryStackView {

	private var horizontalStack = UIStackView()
	private let factory: ICellsFactory
	private var cells: [[UIButton]] = []

	init(factory: ICellsFactory) {
		self.factory = factory
	}

	func makeHorisontalStack(playingView: UIView, countCell: Int, countCollumn: Int, countRow: Int) {
		horizontalStack.removeFromSuperview()
		horizontalStack = UIStackView()
		playingView.addSubview(horizontalStack)
		horizontalStack.axis = .horizontal
		setupGeneral(stackView: horizontalStack, countCell: countCell)
		setupLayout(superView: playingView)

		setupVerticalStack(countCell: countCell, countCollumn: countCollumn, countRow: countRow)
	}
}

private extension FactoryStackView {
	func setupVerticalStack(countCell: Int, countCollumn: Int, countRow: Int) {
		cellDistribution(countCell: countCell, countCollumn: countCollumn, countRow: countRow)
		for iter in 0...countCollumn - 1 {
			let verticalStack = UIStackView()
			verticalStack.axis = .vertical
			setupGeneral(stackView: verticalStack, countCell: countCell)

			for cell in cells[iter] {
				verticalStack.addArrangedSubview(cell)
			}
			horizontalStack.addArrangedSubview(verticalStack)
		}
	}

	func cellDistribution(countCell: Int, countCollumn: Int, countRow: Int) {
		cells = []
		let arrayCell = factory.make(countCell: countCell)
		var counter = 0

		for _ in 0...countCollumn - 1 {
			var collumn: [UIButton] = []
			for _ in 0...countRow - 1 {
				collumn.append(arrayCell[counter])
				counter += 1
			}
			cells.append(collumn)
		}
	}

	func setupLayout(superView: UIView) {
		horizontalStack.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate(
			horizontalStack.pin(to: superView, edges: UIEdgeInsets(top: 5, left: 3, bottom: -5, right: -3))
		)
	}

	func setupGeneral(stackView: UIStackView, countCell: Int) {
		stackView.distribution = .fillEqually
		switch countCell {
		case 0...130:
			stackView.spacing = 3
		case 131...260:
			stackView.spacing = 2
		default:
			stackView.spacing = 1
		}
	}
}
