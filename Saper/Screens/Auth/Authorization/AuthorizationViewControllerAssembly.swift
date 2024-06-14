//
//  AuthorizationViewControllerAssembly.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import Foundation
import UIKit

protocol IAuthorizationViewControllerAssembly {
    func assembly() -> UIViewController
}

final class AuthorizationViewControllerAssembly: IAuthorizationViewControllerAssembly {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func assembly() -> UIViewController {
        let router = AuthorizationRouter(gameViewControllerAssembly: GameViewControllerAssembly())
        router.navigationController = navigationController
        let presenter = AuthorizationPresenter(router: router)
        let viewController = AuthorizationViewController(presenter: presenter)
        return viewController
    }
}
