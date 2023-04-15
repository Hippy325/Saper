//
//  CellBomb.swift
//  Saper
//
//  Created by User on 26.07.2022.
//

import Foundation
import UIKit

final class Cell: UIButton {

	enum SizeOf {
		case small
		case average
		case big
		case huge
	}

	private var isClicked: Bool = false
	private weak var liaison: ILiaisonCells?
	private let shapeLayer = CAShapeLayer()
	private var sizeOfCell: SizeOf?

	convenience init(tag: Int, liaison: ILiaisonCells, sizeOfCell: SizeOf) {
		self.init()
		self.liaison = liaison
		self.setupCell(tag, sizeOfCell: sizeOfCell)
		self.layer.addSublayer(shapeLayer)
	}

	private func setupCell(_ tag: Int, sizeOfCell: SizeOf) {
		self.sizeOfCell = sizeOfCell
		liaison?.appendCell(cell: self)
		backgroundColor = UIColor.gray
		layer.borderColor = UIColor.darkGray.cgColor
		setBorderWidth(sizeOfCell: sizeOfCell)
		setTextFont(sizeOfCell: sizeOfCell)
		self.tag = tag
		addTarget(self, action: #selector(f), for: .touchUpInside)
	}

	@objc private func f() {
		liaison?.notification(position: tag)
	}

	func actionChange(state: Int?) {
		isClicked = true
		isEnabled = false
		guard let state = state else {
			self.backgroundColor = .red
			return
		}
		setTitle("\(state)", for: .normal)
		setTextColor(state: state)
		titleLabel?.adjustsFontSizeToFitWidth = true
		titleLabel?.numberOfLines = 1

		backgroundColor = .white
		return
	}

	func initalState() {
		backgroundColor = .gray
		setTitle("", for: .normal)
		isEnabled = true
		isClicked = false

		guard let sizeOfCell = sizeOfCell else { return }
		setBorderWidth(sizeOfCell: sizeOfCell)
		setTextFont(sizeOfCell: sizeOfCell)
	}

	func clicked() -> Bool {
		return isClicked
	}

	func flag() {
		let path = CGMutablePath()
		path.move(to: CGPoint(x: 17, y: 10))
		path.addLines(between: [
			CGPoint(x: 41, y: 20),
			CGPoint(x: 24, y: 30),
			CGPoint(x: 24, y: 10),
			CGPoint(x: 22, y: 10),
			CGPoint(x: 22, y: 45),
			CGPoint(x: 24, y: 45),
			CGPoint(x: 24, y: 10)
		])
		path.closeSubpath()
		shapeLayer.path = path.copy()
		shapeLayer.fillColor = UIColor.red.cgColor
	}

	func deleteFlag() {
		shapeLayer.path = CGMutablePath()
	}

	private func setTextFont(sizeOfCell: SizeOf) {
		switch sizeOfCell {
		case .small:
			self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
		case .average:
			self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
		case .big:
			self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		case .huge:
			self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
		}
	}

	private func setTextColor(state: Int) {
		switch state {
		case 0:
			self.setTitleColor(.white, for: .normal)
		case 1:
			self.setTitleColor(.blue, for: .normal)
		case 2:
			self.setTitleColor(.green, for: .normal)
		case 3:
			self.setTitleColor(.red, for: .normal)
		case 4:
			self.setTitleColor(.purple, for: .normal)
		default:
			self.setTitleColor(.black, for: .normal)
		}
	}

	private func setBorderWidth(sizeOfCell: SizeOf) {
		switch sizeOfCell {
		case .small:
			layer.borderWidth = 5
		case .average:
			layer.borderWidth = 4
		case .big:
			layer.borderWidth = 3
		case .huge:
			layer.borderWidth = 2
		}
	}
}
