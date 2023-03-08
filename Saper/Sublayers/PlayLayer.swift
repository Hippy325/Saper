//
//  PlayLayer.swift
//  Saper
//
//  Created by User on 28.02.2023.
//

import Foundation
import UIKit

final class Play {
	func play() -> CALayer {
		let shapeLayer = bigCircleBlack()
		shapeLayer.addSublayer(bigCircleWhite())
		shapeLayer.addSublayer(smallCircleBlack())
		shapeLayer.addSublayer(triangle())

		return shapeLayer
	}

	private func bigCircleBlack() -> CAShapeLayer {
		let shapeLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.addArc(
			center: CGPoint(x: 22.5, y: 22.5),
			radius: 16,
			startAngle: .pi, endAngle: -.pi,
			clockwise: true)
		path.closeSubpath()
		shapeLayer.path = path.copy()
		shapeLayer.fillColor = UIColor.black.cgColor

		return shapeLayer
	}

	private func bigCircleWhite() -> CAShapeLayer {
		let shapeLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.addArc(
			center: CGPoint(x: 22.5, y: 22.5),
			radius: 15,
			startAngle: .pi, endAngle: -.pi,
			clockwise: true)
		path.closeSubpath()
		shapeLayer.path = path.copy()
		shapeLayer.fillColor = UIColor.white.cgColor

		return shapeLayer
	}

	private func smallCircleBlack() -> CAShapeLayer {
		let shapeLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.addArc(
			center: CGPoint(x: 22.5, y: 22.5),
			radius: 14,
			startAngle: .pi, endAngle: -.pi,
			clockwise: true)
		path.closeSubpath()
		shapeLayer.path = path.copy()
		shapeLayer.fillColor = UIColor.black.cgColor

		return shapeLayer
	}

	private func triangle() -> CAShapeLayer {
		let shapeLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.move(to: CGPoint(x: 31, y: 22.5))
		path.addLines(between: [
			CGPoint(x: 16, y: 31),
			CGPoint(x: 16, y: 14),
			CGPoint(x: 31, y: 22.5)
		])
		path.closeSubpath()
		shapeLayer.path = path.copy()
		shapeLayer.fillColor = UIColor.white.cgColor

		return shapeLayer
	}
}
