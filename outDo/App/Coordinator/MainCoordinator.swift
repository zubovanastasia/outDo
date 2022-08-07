//
//  MainCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

class MainCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let coordinatorFactory: CoordinatorFactory
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory, coordinatorFactory: CoordinatorFactory) {
        self.coordinatorFactory = coordinatorFactory
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        startMainFlow()
    }
    
    // MARK: - Current Flow
    private func startMainFlow() {
        let screen = screenFactory.makeMainScreen()
//        screen.presenter.onSignIn = { [weak self] in
//            self?.finishFlow?()
//        }
        router.setRootModule(screen, hideBar: true)
    }
}
