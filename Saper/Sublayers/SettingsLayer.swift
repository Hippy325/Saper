//
//  SettingsLayer.swift
//  Saper
//
//  Created by User on 28.02.2023.
//

import Foundation
import UIKit

final class Settings {
	func setings() -> CALayer {
		let layer = Semicircle().semicircle(side: .left)

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
		layer.addSublayer(threeLine(color: .black))
		return layer
	}

	private func threeLine(color: UIColor) -> CAShapeLayer {
		let shapeLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.move(to: CGPoint(x: 9, y: 11))
		path.addLines(between: [
			CGPoint(x: 36, y: 11),
			CGPoint(x: 36, y: 14),
			CGPoint(x: 9, y: 14),
			CGPoint(x: 9, y: 11)
		])

		path.move(to: CGPoint(x: 9, y: 20.5))
		path.addLines(between: [
			CGPoint(x: 36, y: 20.5),
			CGPoint(x: 36, y: 23.5),
			CGPoint(x: 9, y: 23.5),
			CGPoint(x: 9, y: 20.5)
		])

		path.move(to: CGPoint(x: 9, y: 30))
		path.addLines(between: [
			CGPoint(x: 36, y: 30),
			CGPoint(x: 36, y: 33),
			CGPoint(x: 9, y: 33),
			CGPoint(x: 9, y: 30)
		])
		path.closeSubpath()
		shapeLayer.path = path.copy()
		shapeLayer.fillColor = color.cgColor

		return shapeLayer
	}
}
