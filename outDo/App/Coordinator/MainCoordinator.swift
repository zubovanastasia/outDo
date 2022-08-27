//
//  MainCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

final class MainCoordinator: BaseCoordinator {
    
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
        screen.presenter.onHandleAction = { [weak self] action, data in
            switch action {
            case .add:
                self?.runTaskCreateFlow()
            case .app:
                self?.runAboutAppFlow()
            case .profile:
                self?.runProfileFlow()
            case .policy:
                self?.runPolicyFlow(data as? NavigationDrawerCellModel)
            case .signIn:
                self?.finishFlow?()
            default: return
            }
        }
        router.setRootModule(screen)
    }
    
    // MARK: - Next Flow
    private func runAboutAppFlow() {
        let coordinator = coordinatorFactory.makeAboutAppCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runProfileFlow() {
        let coordinator = coordinatorFactory.makeProfileCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runPolicyFlow(_ data: NavigationDrawerCellModel?) {
        guard let data = data else { return }
        let webData = WebData(
            action: data.action,
            title: data.title,
            url: Config.shared.urlPolicy)
        let coordinator = coordinatorFactory.makeWebCoordinator(router: router, data: webData)
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTaskCreateFlow() {
        let coordinator = coordinatorFactory.makeTaskCreateCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
