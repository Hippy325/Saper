//
//  GameViewControllerAssembly.swift
//  App
//
//  Created by Тигран Гарибян on 14.05.2024.
//

import Foundation
import UIKit

protocol IGameViewControllerAssembly {
    func assembly() -> UIViewController
}

final class GameViewControllerAssembly: IGameViewControllerAssembly {

    func assembly() -> UIViewController {
        let viewConreollerRouter = GameRouter(settingsViewControllerAssembly: SettingsViewControllerAssembly())
        let lision = Liaison()
        let creator = CellsFactory(liaison: lision)
        let creatingStackView = FactoryStackView(factory: creator)
        let presenter = GamePresenter(liaison: lision, router: viewConreollerRouter)
        lision.setPresenter(presenter: presenter)

        let viewController = GameViewController(
            factoryStackView: creatingStackView,
            presenter: presenter
        )
        presenter.view = viewController
        viewConreollerRouter.viewController = viewController
        return viewController
    }
}
