//
//  ProfileCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class ProfileCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        startProfileFlow()
    }
    
    // MARK: - Current Flow
    private func startProfileFlow() {
        let screen = screenFactory.makeProfileScreen()
        // TODO: -
//        screen.presenter.onBack = {}
//        screen.presenter.onSignOut = { [weak self] in
//            self?.runLoginFlow()
//        }
        router.push(screen)
    }
    
    // MARK: - Next Flow
    // TODO: -
    private func runLoginFlow() {
//        router.popToRootModule(animated: true)
//        ((router.toPresent() as? UINavigationController)?.topViewController as? MainVC)?.presenter.onHandleAction?(.signIn, nil)
    }
}
