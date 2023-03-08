//
//  CellBomb.swift
//  Saper
//
//  Created by User on 26.07.2022.
//

import Foundation
import UIKit

final class Cell: UIButton {

	private weak var liaison: ILiaison?
	private let shapeLayer = CAShapeLayer()
	convenience init(tag: Int, liaison: ILiaison) {
		self.init()
		self.liaison = liaison
		self.setupCell(tag)
		self.layer.addSublayer(shapeLayer)
	}

	private func setupCell(_ tag: Int) {
		liaison?.appendCell(cell: self)
		backgroundColor = UIColor.gray
		self.layer.borderColor = UIColor.darkGray.cgColor
		self.tag = tag
		layer.borderWidth = 5
		self.addTarget(self, action: #selector(f), for: .touchUpInside)
	}

	@objc private func f() {
		liaison?.notification(position: tag)
	}

	func actionChange(state: Int?) {
		guard let state = state else {
			self.backgroundColor = .red
			return
		}
		self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
		self.setTitle("\(state)", for: .normal)
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
		self.backgroundColor = .white
		return
	}

	func initalState() {
		self.backgroundColor = .gray
		layer.borderWidth = 5
		self.setTitle("", for: .normal)
		self.isEnabled = true
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
}
