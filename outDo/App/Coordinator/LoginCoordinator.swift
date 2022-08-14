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
        screen.presenter.onSignUp = { [weak self] in
            self?.runSignUpFlow()
        }
        router.setRootModule(screen, hideBar: true)
    }
    
    // MARK: - Next Flow
    private func runSignUpFlow() {
        let coordinator = coordinatorFactory.makeSignUpCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}

