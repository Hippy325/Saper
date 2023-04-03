//
//  SettingsViewControllerPresenter.swift
//  App
//
//  Created by User on 30.03.2023.
//

import Foundation

protocol ISettingsViewControllerPresenter {
	func setCountCell(parametrs: Int)
	func setCountBomb(countBomb: Int)
}

protocol UpdatingViewSettings {
	func updateCountCell(countCell: Int)
	func updateCountBomb(countBomb: Int)
}

final class SettingsViewControllerPresenter: ISettingsViewControllerPresenter {
	var view: UpdatingViewSettings?
	private var countCell: Int = 77 {
		didSet {
			self.view?.updateCountCell(countCell: countCell)
		}
	}

	private var countBomb: Int = 10 {
		didSet {
			self.view?.updateCountBomb(countBomb: countBomb)
		}
	}

	func setCountCell(parametrs: Int) {
		countCell = AlgoritmFieldParametrs.countCell(properties: parametrs)
	}

	func setCountBomb(countBomb: Int) {
		self.countBomb = countBomb
	}
}
