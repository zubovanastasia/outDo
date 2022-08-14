//
//  SignUpCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

class SignUpCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        startSignUpFlow()
    }
    
    // MARK: - Current Flow
    private func startSignUpFlow() {
        let screen = screenFactory.makeSignUpScreen()
        screen.presenter.onSignUp = { [weak self] in
            self?.finishFlow?()
        }
        router.push(screen)
    }
}
