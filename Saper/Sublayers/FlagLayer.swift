//
//  Flag.swift
//  Saper
//
//  Created by User on 28.02.2023.
//

import Foundation
import UIKit

final class Flag {
	private let layer = Semicircle().semicircle(side: .right)
	private let flagLayer = CAShapeLayer()

	func flag(color: UIColor) -> CALayer {
		let circle = CAShapeLayer()
		let path = CGMutablePath()
		path.addArc(
			center: CGPoint(x: 22.5, y: 22.5),
			radius: 22.5,
			startAngle: .pi, endAngle: -.pi,
			clockwise: true)
		path.closeSubpath()
		circle.path = path.copy()
		circle.fillColor = UIColor.darkGray.cgColor
		layer.addSublayer(circle)
		layer.addSublayer(flagRed(color: color))
		return layer
	}

	func setColor(color: UIColor) {
		flagLayer.fillColor = color.cgColor
	}
	private func flagRed(color: UIColor) -> CALayer {
		let path = CGMutablePath()
		path.move(to: CGPoint(x: 12, y: 5))
		path.addLines(between: [
			CGPoint(x: 36, y: 15),
			CGPoint(x: 19, y: 25),
			CGPoint(x: 19, y: 5),
			CGPoint(x: 17, y: 5),
			CGPoint(x: 17, y: 40),
			CGPoint(x: 19, y: 40),
			CGPoint(x: 19, y: 5)
		])
		path.closeSubpath()
		flagLayer.path = path.copy()
		flagLayer.fillColor = color.cgColor

		return flagLayer
	}
}
