//
//  TaskCreateCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 26.08.2022.
//

import UIKit

final class TaskCreateCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        startTaskCreateFlow()
    }
    
    // MARK: - Current Flow
    private func startTaskCreateFlow() {
        let screen = screenFactory.makeTaskCreateScreen()
        screen.presenter.onBack = {}
        router.push(screen)
    }
}
