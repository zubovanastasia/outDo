//
//  WebCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

class WebCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    private let data: WebData
    
    init(router: Router, screenFactory: ScreenFactory, data: WebData) {
        self.router = router
        self.screenFactory = screenFactory
        self.data = data
    }
    
    override func start() {
        startWebFlow()
    }
    
    // MARK: - Current Flow
    private func startWebFlow() {
        // TODO: -
        let screen = screenFactory.makeWebScreen(data: data)
        screen.presenter.onBack = {}
        router.push(screen)
    }
}

