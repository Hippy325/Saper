//
//  FacadeForCreatingStackView.swift
//  Saper
//
//  Created by User on 07.08.2022.
//

import Foundation
import UIKit

protocol ICreatingStackView {
	func creatingHoririsontalyStacks(view: UIView, count: Int)
}

final class CreatingStackView: ICreatingStackView {

	private let horizontalStack = UIStackView()
	private let creatingCells: ICreatingCells
	private var cells: [[UIButton]] = []

	init(creatingCells: ICreatingCells) {
		self.creatingCells = creatingCells
	}

	private func setupVerticalStack(count: Int) {
		cellDistribution(count: count)
		for iter in 0...(count / 11) - 1 {
			let verticalStack = UIStackView()
			verticalStack.axis = .vertical
			verticalStack.spacing = 3
			verticalStack.distribution = .fillEqually

			for cell in cells[iter] {
				verticalStack.addArrangedSubview(cell)
			}
			horizontalStack.addArrangedSubview(verticalStack)
		}
	}

	func creatingHoririsontalyStacks(view: UIView, count: Int) {
		view.addSubview(horizontalStack)
		horizontalStack.axis = .horizontal
		horizontalStack.spacing = 3
		horizontalStack.distribution = .fillEqually
		horizontalStack.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			horizontalStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
			horizontalStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 3),
			horizontalStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -3),
			horizontalStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
		])

		setupVerticalStack(count: count)
	}

	private func cellDistribution(count: Int) {
		let array = creatingCells.getCells(count: count)
		var counter = 0

		for _ in 0...(count / 11) - 1 {
			var arr: [UIButton] = []
			for _ in 0...10 {
				arr.append(array[counter])
				counter += 1
			}
			cells.append(arr)
		}
	}
}
