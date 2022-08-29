//
//  TaskCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

import UIKit

final class TaskCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    private let taskId: Int
    
    init(router: Router, screenFactory: ScreenFactory, taskId: Int) {
        self.router = router
        self.screenFactory = screenFactory
        self.taskId = taskId
    }
    
    override func start() {
        startTaskFlow()
    }
    
    // MARK: - Current Flow
    private func startTaskFlow() {
        let screen = screenFactory.makeTaskScreen(taskId: taskId)
        screen.presenter.onBack = {}
        router.push(screen)
    }
}
