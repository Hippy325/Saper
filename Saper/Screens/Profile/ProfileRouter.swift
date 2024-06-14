//
//  ProfileRouter.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import Foundation
import UIKit

protocol IProfileRouter {
    func goToBack()
}

final class ProfileRouter {

    var viewController: UIViewController?
}

extension ProfileRouter: IProfileRouter {
    func goToBack() {
    }
}
