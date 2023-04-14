//
//  MatrixPositionResultBuilder.swift
//  App
//
//  Created by User on 14.04.2023.
//

import Foundation
import SwiftUI

@_functionBuilder final class MatrixPositionResultBuilder {
	static func buildBlock(_ components: [MatrixPosition]...) -> [MatrixPosition] {
		return components.flatMap { $0 }
	}

	static func buildExpression(_ expression: MatrixPosition) -> [MatrixPosition] {
		[expression]
	}

	static func buildExpression(_ expression: [MatrixPosition]) -> [MatrixPosition] {
		expression
	}

	static func buildOptional(_ components: [MatrixPosition]?) -> [MatrixPosition] {
		components ?? []
	}

	static func buildIf(_ content: [MatrixPosition]?) -> [MatrixPosition] {
		content ?? []
	}

	static func buildEither(first: [MatrixPosition]) -> [MatrixPosition] {
		first
	}

	static func buildEither(second: [MatrixPosition]) -> [MatrixPosition] {
		second
	}
}
