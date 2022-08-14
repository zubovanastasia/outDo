//
//  MainVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

import UIKit

protocol MainView: AnyObject {

}

class MainVC: UIViewController, MainView {

    // MARK: - Outlets
    private var menuButton: UIButton!
    
    
    // MARK: - Properties
    var presenter: MainPresenter
    
    
    // MARK: - View
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private
    private func configure() {
        menuButton = UIButton(type: .custom)
        menuButton.frame = CGRect(x: 0, y: 0, width: 28, height: 44)
        menuButton.setImage(UIImage(named: Assets.shared.appbarMenu), for: .normal)
        menuButton.addTarget(self, action: #selector(onTapNavbarMenu), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItems = [
            UIBarButtonItem(customView: menuButton)
        ]
    }
    
    // MARK: - Taps
    @objc private func onTapNavbarMenu() {
        self.presenter.onTapNavbarMenu()
    }
}
