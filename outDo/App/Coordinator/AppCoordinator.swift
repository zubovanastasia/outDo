//
//  AppCoordinator.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit
import Combine

class AppCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let profileProvider: ProfileProvider
    private let deviceProvider: DeviceProvider
    private let router: Router
    
    private var isFirstLaunch = true
    private var isAuthed = false
    private var deviceCancellable: AnyCancellable?
    
    var onSignOut: VoidClosure?
    
    var currentScreen: UIViewController? {
        get { return (router.toPresent() as? UINavigationController)?.topViewController }
    }
    
    init(router: Router, coordinatorFactory: CoordinatorFactory, providerFactory: ProviderFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.profileProvider = providerFactory.profileProvider
        self.deviceProvider = providerFactory.deviceProvider
    }
    
    override func start() {
        if isFirstLaunch {
            runLaunchFlow()
            isFirstLaunch = false
            return
        }
        
        if isAuthed {
            profileProvider.profileGet(completion: { [weak self] response in
                // MARK: TODO
                //Socket.shared.create()
                if response == nil {
                    self?.isAuthed = false
                    self?.runLoginFlow()
                }
                else {
                    self?.runMainFlow()
                }
            })
        }
        else {
            self.onSignOut?()
            runLoginFlow()
        }
    }
    
    func restart() {
        isAuthed = false
        isFirstLaunch = true
        start()
    }
    
    // MARK: - Next Flow
    private func runCriticalFlow() {
//        let coordinator = coordinatorFactory.makeCriticalCoordinator(router: router)
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            self?.start()
//            self?.removeDependency(coordinator)
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
    }
    
    private func runLaunchFlow() {
        let coordinator = coordinatorFactory.makeLaunchCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] isAuthed in
            self?.isAuthed = isAuthed
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runLoginFlow() {
        makeApiDeviceSave()
        let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isAuthed = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        makeApiDeviceSave()
        let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isFirstLaunch = false
            self?.isAuthed = false
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Api
    private func makeApiDeviceSave() {
        deviceCancellable = self.deviceProvider.save().sink(receiveValue: { data in })
    }
}

