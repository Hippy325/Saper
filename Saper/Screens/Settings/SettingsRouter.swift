//
//  SettingsRouter.swift
//  App
//
//  Created by User on 31.03.2023.
//

import Foundation
import UIKit

protocol ISettingsRouter {
	func backToPlaingScreen()
    func pushToProfileScreen()
}

final class SettingsRouter {
	var viewController: UIViewController?
}

extension SettingsRouter: ISettingsRouter {
	func backToPlaingScreen() {
		viewController?.dismiss(animated: true, completion: nil)
	}
    
    func pushToProfileScreen() {
        
    }
}
