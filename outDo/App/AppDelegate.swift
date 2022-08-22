//
//  AppDelegate.swift
//  outDo
//
//  Created by Anastasiia Zubova on 30.07.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var factory: Factory = { return Factory() }()
    var appCoordinator: AppCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().titleTextAttributes = Styles.shared.getAttributes(Styles.shared.view.navbarPrC)

        UINavigationBar.appearance().backIndicatorImage = UIImage(named: Assets.shared.appbarBack)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: Assets.shared.appbarBack)
        UINavigationBar.appearance().tintColor = Styles.shared.getFontColor(Styles.shared.view.navbarPr)
        UINavigationBar.appearance().backgroundColor = .white
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0.1), NSAttributedString.Key.foregroundColor: UIColor.clear]
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributes, for: .highlighted)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let router = RouterImpl(rootController: navigationController)
        appCoordinator = factory.coordinatorFactory.makeAppCoordinator(router: router)
        appCoordinator?.onSignOut = { [weak self] in
            self?.factory.clear()
        }
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator?.start()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        var deviceProvider = factory.providerFactory.deviceProvider
        deviceProvider.isBackground = true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        var deviceProvider = factory.providerFactory.deviceProvider
        deviceProvider.isBackground = false
        application.applicationIconBadgeNumber = 0
    }
    
    func restart() {
        self.factory.clear()
        appCoordinator?.restart()
    }
}
