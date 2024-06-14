//
//  Xmark.swift
//  App
//
//  Created by User on 31.03.2023.
//

import Foundation
import UIKit

final class Xmark {
	func xmark() -> CALayer {
		let shapeLayer = CAShapeLayer()
		let path = CGMutablePath()
		path.move(to: CGPoint(x: 6, y: 9))
		path.addLines(between: [
			CGPoint(x: 9, y: 6),
			CGPoint(x: 50, y: 47),
			CGPoint(x: 47, y: 50),
			CGPoint(x: 6, y: 9)
		])

		path.move(to: CGPoint(x: 6, y: 47))
		path.addLines(between: [
			CGPoint(x: 9, y: 50),
			CGPoint(x: 50, y: 9),
			CGPoint(x: 47, y: 6),
			CGPoint(x: 6, y: 47)
		])
		path.closeSubpath()
		shapeLayer.path = path
		shapeLayer.fillColor = UIColor.black.cgColor

		return shapeLayer
	}
}
