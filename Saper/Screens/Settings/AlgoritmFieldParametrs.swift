//
//  AlgoritmFieldParametrs.swift
//  App
//
//  Created by User on 03.04.2023.
//

import Foundation

final class AlgoritmFieldParametrs {
	static func countRow(properties: Int) -> Int {
		properties / 7
	}

	static func countCollumn(properties: Int) -> Int {
		properties / 11
	}

	static func countCell(properties: Int) -> Int {
		Int(properties / 7) * Int(properties / 11)
	}
}
