//
//  Factory.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//
//

import Foundation

protocol FactoryIssue {
    
    var providerFactory: ProviderFactory { get }
    var coordinatorFactory: CoordinatorFactory { get }
    
    func clear()
}

final class Factory: FactoryIssue {
    
    fileprivate let keychainWrapper: KeychainWrapper
    fileprivate let requestFactory: RequestFactory
    fileprivate let repositoryFactory: RepositoryFactory
    fileprivate let userDefaultsProvider: UserDefaultsProvider
    fileprivate let serviceFactory: ServiceFactory
    let providerFactory: ProviderFactory
    fileprivate let screenFactory: ScreenFactory
    let coordinatorFactory: CoordinatorFactory
    
    let stopwatch: Stopwatch = StopWatchImpl()
    
    init() {
        // storage
        keychainWrapper = KeychainWrapperImpl.standard
        userDefaultsProvider = UserDefaultsProviderImpl()
        
        // repository
        repositoryFactory = RepositoryFactoryImpl(
            keychainWrapper: keychainWrapper,
            userDefaultsProvider: userDefaultsProvider,
            stopwatch: stopwatch)
        
        // api
        requestFactory = RequestFactory(
            stopwatch: stopwatch,
            repositoryFactory: repositoryFactory)
        
        // provider
        serviceFactory = ServiceFactoryImpl(
            repositoryFactory: repositoryFactory,
            requestFactory: requestFactory,
            stopwatch: stopwatch,
            userDefaultsProvider: userDefaultsProvider)
        providerFactory = ProviderFactoryImpl(serviceFactory: serviceFactory)
        
        // coordinator
        screenFactory = ScreenFactoryImpl(
            serviceFactory: serviceFactory,
            providerFactory: providerFactory,
            userDefaultsProvider: userDefaultsProvider,
            stopwatch: stopwatch)
        
        // coordinator
        coordinatorFactory = CoordinatorFactoryImpl(
            screenFactory: screenFactory,
            providerFactory: providerFactory)
        
        DialogBuilder.shared.screenFactory = screenFactory
    }
    
    func clear() {
        repositoryFactory.clear()
    }
}

// MARK: - Coordinator
protocol CoordinatorFactory: AnyObject {
    
    func makeAboutAppCoordinator(router: Router) -> AboutAppCoordinator
    func makeAppCoordinator(router: Router) -> AppCoordinator
    func makeLaunchCoordinator(router: Router) -> LaunchCoordinator
    func makeLoginCoordinator(router: Router) -> LoginCoordinator
    func makeMainCoordinator(router: Router) -> MainCoordinator
    func makeProfileCoordinator(router: Router) -> ProfileCoordinator
    func makeSignUpCoordinator(router: Router) -> SignUpCoordinator
    func makeWebCoordinator(router: Router, data: WebData) -> WebCoordinator
}

class CoordinatorFactoryImpl: CoordinatorFactory {
    
    private let screenFactory: ScreenFactory
    private let providerFactory: ProviderFactory
    
    init(screenFactory: ScreenFactory, providerFactory: ProviderFactory) {
        self.screenFactory = screenFactory
        self.providerFactory = providerFactory
    }
    
    func makeAppCoordinator(router: Router) -> AppCoordinator {
        return AppCoordinator(
            router: router,
            coordinatorFactory: self,
            providerFactory: providerFactory)
    }
    
    // MARK: - Screen
    func makeAboutAppCoordinator(router: Router) -> AboutAppCoordinator {
        return AboutAppCoordinator(
            router: router,
            screenFactory: screenFactory)
    }
    
    func makeLaunchCoordinator(router: Router) -> LaunchCoordinator {
        return LaunchCoordinator(
            router: router,
            screenFactory: screenFactory)
    }
    
    func makeLoginCoordinator(router: Router) -> LoginCoordinator {
        return LoginCoordinator(
            router: router,
            screenFactory: screenFactory,
            coordinatorFactory: self)
    }
    
    func makeMainCoordinator(router: Router) -> MainCoordinator {
        return MainCoordinator(
            router: router,
            screenFactory: screenFactory,
            coordinatorFactory: self)
    }
    
    func makeProfileCoordinator(router: Router) -> ProfileCoordinator {
        return ProfileCoordinator(
            router: router,
            screenFactory: screenFactory)
    }
    
    func makeSignUpCoordinator(router: Router) -> SignUpCoordinator {
        return SignUpCoordinator(
            router: router,
            screenFactory: screenFactory)
    }
    
    func makeWebCoordinator(router: Router, data: WebData) -> WebCoordinator {
        return WebCoordinator(
            router: router,
            screenFactory: screenFactory,
            data: data)
    }
}

// MARK: - Provider
protocol ProviderFactory: AnyObject {
    
    var authProvider: AuthProvider { get }
    var authStatusProvider: AuthStatusProvider { get }
    var deviceProvider: DeviceProvider { get }
    var profileProvider: ProfileProvider { get }
    var signUpProvider: SignUpProvider { get }
}

class ProviderFactoryImpl: ProviderFactory {
    
    private let serviceFactory: ServiceFactory
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
    }
    
    var authProvider: AuthProvider {
        get { return AuthProviderImpl(authService: serviceFactory.authService) }
    }
    
    var authStatusProvider: AuthStatusProvider {
        get { return AuthStatusProviderImpl(authService: serviceFactory.authService) }
    }
    
    var deviceProvider: DeviceProvider {
        get { return DeviceProviderImpl(deviceService: serviceFactory.deviceService) }
    }
    
    var profileProvider: ProfileProvider {
        get { return ProfileProviderImpl(profileService: serviceFactory.profileService) }
    }
    
    var signUpProvider: SignUpProvider {
        get { return SignUpProviderImpl(authService: serviceFactory.authService) }
    }
}

// MARK: - Repository
protocol RepositoryFactory: AnyObject {
    
    var authRepository: AuthRepository { get }
    var deviceRepository: DeviceRepository { get }
    var profileRepository: ProfileRepository { get }
    
    func clear()
}

class RepositoryFactoryImpl: RepositoryFactory {
    
    var authRepository: AuthRepository
    var deviceRepository: DeviceRepository
    var profileRepository: ProfileRepository
    
    init(keychainWrapper: KeychainWrapper, userDefaultsProvider: UserDefaultsProvider, stopwatch: Stopwatch) {
        authRepository = AuthRepositoryImpl(keychainWrapper: keychainWrapper)
        deviceRepository = DeviceRepositoryImpl(userDefaultsProvider: userDefaultsProvider, timezone: stopwatch.timezone)
        profileRepository = ProfileRepositoryImpl(userDefaultsProvider: userDefaultsProvider)
    }
    
    func clear() {
        authRepository.clear()
        profileRepository.clear()
    }
}

// MARK: - Screen
protocol ScreenFactory: AnyObject {
    
    // MARK: - Drawer
    func makeNavigationDrawerPopup() -> NavigationDrawerPopup
    
    // MARK: - Popups
    func makeAlertPopup(data: AlertData) -> AlertPopup
    func makeToastPopup(message: String) -> ToastPopup
    
    // MARK: - Screens
    func makeAboutAppScreen() -> AboutAppVC
    func makeLaunchScreen() -> LaunchVC
    func makeLoginScreen() -> LoginVC
    func makeMainScreen() -> MainVC
    func makeProfileScreen() -> ProfileVC
    func makeSignUpScreen() -> SignUpVC
    func makeWebScreen() -> WebVC
}

class ScreenFactoryImpl: ScreenFactory {
    
    private let serviceFactory: ServiceFactory
    private let providerFactory: ProviderFactory
    private let userDefaultsProvider: UserDefaultsProvider
    private let stopwatch: Stopwatch
    
    init(serviceFactory: ServiceFactory, providerFactory: ProviderFactory, userDefaultsProvider: UserDefaultsProvider, stopwatch: Stopwatch) {
        self.serviceFactory = serviceFactory
        self.providerFactory = providerFactory
        self.userDefaultsProvider = userDefaultsProvider
        self.stopwatch = stopwatch
    }
    
    // MARK: - Drawer
    func makeNavigationDrawerPopup() -> NavigationDrawerPopup {
        let interactor = NavigationDrawerInteractorImpl(profileProvider: providerFactory.profileProvider)
        let presenter = NavigationDrawerPresenterImpl(interactor: interactor)
        let viewController = NavigationDrawerPopup(presenter: presenter)

        interactor.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    // MARK: - Popups
    func makeAlertPopup(data: AlertData) -> AlertPopup {
        return AlertPopup(
            data: data,
            deviceProvider: providerFactory.deviceProvider)
    }
    
    func makeToastPopup(message: String) -> ToastPopup {
        return ToastPopup(message: message)
    }
    
    // MARK: - Screens
    func makeAboutAppScreen() -> AboutAppVC {
//        let interactor = AboutAppInteractorImpl(deviceProvider: providerFactory.deviceProvider)
//        let presenter = AboutAppPresenterImpl(interactor: interactor)
//        let viewController = AboutAppVC(presenter: presenter)
//
//        interactor.presenter = presenter
//        presenter.view = viewController
//
//        return viewController
        return AboutAppVC()
    }
    
    func makeLaunchScreen() -> LaunchVC {
        return LaunchVC(authStatusProvider: providerFactory.authStatusProvider)
    }
    
    func makeLoginScreen() -> LoginVC {
        let interactor = LoginInteractorImpl(authProvider: providerFactory.authProvider)
        let presenter = LoginPresenterImpl(interactor: interactor)
        let viewController = LoginVC(presenter: presenter)
        
        interactor.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func makeMainScreen() -> MainVC {
        let interactor = MainInteractorImpl()
        let presenter = MainPresenterImpl(interactor: interactor)
        let viewController = MainVC(presenter: presenter)
        
        interactor.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func makeProfileScreen() -> ProfileVC {
//        let interactor = ProfileInteractorImpl(
//            authProvider: providerFactory.authProvider,
//            profileProvider: providerFactory.profileProvider)
//        let presenter = ProfilePresenterImpl(interactor: interactor)
//        let viewController = ProfileVC(presenter: presenter)
//
//        interactor.presenter = presenter
//        presenter.view = viewController
//
//        return viewController
        return ProfileVC()
    }
    
    func makeSignUpScreen() -> SignUpVC {
        let interactor = SignUpInteractorImpl(signUpProvider: providerFactory.signUpProvider)
        let presenter = SignUpPresenterImpl(interactor: interactor)
        let viewController = SignUpVC(presenter: presenter)
        
        interactor.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func makeWebScreen() -> WebVC {
        return WebVC()
    }
}

// MARK: - Service
protocol ServiceFactory: AnyObject {
    
    var authService: AuthService { get }
    var deviceService: DeviceService { get }
    var profileService: ProfileService { get }
}

class ServiceFactoryImpl: ServiceFactory {
    
    private let repositoryFactory: RepositoryFactory
    private let requestFactory: RequestFactory
    private let stopwatch: Stopwatch
    private let userDefaultsProvider: UserDefaultsProvider
    
    init(repositoryFactory: RepositoryFactory, requestFactory: RequestFactory, stopwatch: Stopwatch, userDefaultsProvider: UserDefaultsProvider) {
        self.repositoryFactory = repositoryFactory
        self.requestFactory = requestFactory
        self.stopwatch = stopwatch
        self.userDefaultsProvider = userDefaultsProvider
    }
    
    lazy var authService: AuthService = {
        return AuthServiceImpl(
            authRepository: repositoryFactory.authRepository,
            requestFactory: requestFactory)
    }()
    
    lazy var deviceService: DeviceService = {
        return  DeviceServiceImpl(
            repositoryFactory: repositoryFactory,
            requestFactory: requestFactory)
    }()
    
    lazy var profileService: ProfileService = {
        return ProfileServiceImpl(
            repositoryFactory: repositoryFactory,
            requestFactory: requestFactory)
    }()
}
