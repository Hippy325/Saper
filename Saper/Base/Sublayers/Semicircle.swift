//
//  Semicircle.swift
//  Saper
//
//  Created by User on 28.02.2023.
//

import Foundation
import UIKit

final class Semicircle {
	enum Side {
		case right
		case left
	}

	func semicircle(side: Side) -> CALayer {
		let shapeLayer = bigSemicircle(side: side)
		shapeLayer.addSublayer(smallSemiricle(side: side))
		shapeLayer.addSublayer(hidden(side: side))
		return shapeLayer
	}

	private func smallSemiricle(side: Side) -> CAShapeLayer {
		var angle: CGFloat
		var flag: Bool

		if side == .left {
			flag = true
			angle = 1.014
		} else {
			flag = false
			angle = 2.129
		}

		let shapeLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.addArc(
			center: CGPoint(x: 22.5, y: 22.5),
			radius: 26.5,
			startAngle: angle, endAngle: -angle,
			clockwise: flag)
		path.closeSubpath()
		shapeLayer.path = path.copy()
		shapeLayer.fillColor = UIColor.lightGray.cgColor

		return shapeLayer
	}

	private func bigSemicircle(side: Side) -> CAShapeLayer {
		var angle: CGFloat
		var flag: Bool

		if side == .left {
			angle = 0.897
			flag = true
		} else {
			angle = 2.244
			flag = false
		}

		let shapeLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.addArc(
			center: CGPoint(x: 22.5, y: 22.5),
			radius: 35,
			startAngle: angle, endAngle: -angle,
			clockwise: flag)
		path.closeSubpath()
		shapeLayer.path = path.copy()
		shapeLayer.fillColor = UIColor.darkGray.cgColor

		return shapeLayer
	}

	private func hidden(side: Side) -> CAShapeLayer {
		var oneX: Int
		var twoX: Int

		if side == .left {
			oneX = 40
			twoX = 55
		} else {
			oneX = 5
			twoX = -15
		}

		let hidd = CAShapeLayer()
		let path = CGMutablePath()
		path.move(to: CGPoint(x: oneX, y: 0))
		path.addLines(between: [
			CGPoint(x: Double(twoX), y: 0),
			CGPoint(x: Double(twoX), y: -7.5),
			CGPoint(x: Double(oneX), y: -7.5),
			CGPoint(x: Double(oneX), y: 0)
		])
		path.closeSubpath()
		hidd.path = path.copy()
		hidd.fillColor = UIColor.lightGray.cgColor

		let hiddT = CAShapeLayer()
		let pathT = CGMutablePath()
		pathT.move(to: CGPoint(x: oneX, y: 45))
		pathT.addLines(between: [
			CGPoint(x: twoX, y: 45),
			CGPoint(x: twoX, y: 50),
			CGPoint(x: oneX, y: 50),
			CGPoint(x: oneX, y: 45)
		])
		pathT.closeSubpath()
		hiddT.path = pathT.copy()
		hiddT.fillColor = UIColor.lightGray.cgColor
		hidd.addSublayer(hiddT)

		return hidd
	}
}
