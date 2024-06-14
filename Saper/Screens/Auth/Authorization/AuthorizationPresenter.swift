//
//  AuthorizationPresenter.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import Foundation

protocol IAuthorizationPresenter {
    func signIn()
    func signUp()
}

final class AuthorizationPresenter {

    private let router: IAuthorizationRouter

    init(router: IAuthorizationRouter) {
        self.router = router
    }

}

extension AuthorizationPresenter: IAuthorizationPresenter {
    func signIn() {
        router.pushGameScreen()
    }
    
    func signUp() {
        router.pushRegistrationScreen()
    }
}
