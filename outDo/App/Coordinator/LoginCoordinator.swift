//
//  LoginCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

class LoginCoordinator: BaseCoordinator {
    
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
        startLoginFlow()
    }
    
    // MARK: - Current Flow
    private func startLoginFlow() {
        let screen = screenFactory.makeLoginScreen()
        screen.presenter.onSignIn = { [weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(screen, hideBar: true)
    }
}

