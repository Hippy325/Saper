//
//  AuthorizationRouter.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import UIKit

protocol IAuthorizationRouter {
    func pushRegistrationScreen()
    func pushGameScreen()
}

final class AuthorizationRouter {
    private let gameViewControllerAssembly: IGameViewControllerAssembly
    var navigationController: UINavigationController?

    init(gameViewControllerAssembly: IGameViewControllerAssembly) {
        self.gameViewControllerAssembly = gameViewControllerAssembly
    }
}

extension AuthorizationRouter: IAuthorizationRouter {

    func pushRegistrationScreen() {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(RegistrationViewController(), animated: true)
    }

    func pushGameScreen() {
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(gameViewControllerAssembly.assembly(), animated: true)
    }
}
