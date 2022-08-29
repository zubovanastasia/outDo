//
//  AboutAppCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

final class AboutAppCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.router = router
        self.screenFactory = screenFactory
    }
    
    override func start() {
        startAppFlow()
    }
    
    // MARK: - Current Flow
    private func startAppFlow() {
        let screen = screenFactory.makeAboutAppScreen()
        // TODO: -
        //screen.presenter.onBack = {}
        router.push(screen)
    }
}


