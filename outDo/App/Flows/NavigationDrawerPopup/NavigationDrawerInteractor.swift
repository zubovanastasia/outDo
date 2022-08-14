//
//  NavigationDrawerInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import Foundation

protocol NavigationDrawerInteractor {
    
    func getEmail() -> String
    func getName() -> String
    func onTapAction(_ action: TAction)
    func updateCells()
}

final class NavigationDrawerInteractorImpl: NavigationDrawerInteractor {
    
    private var profileProvider: ProfileProvider
    weak var presenter: NavigationDrawerPresenter?
    
    init(profileProvider: ProfileProvider) {
        self.profileProvider = profileProvider
    }
    
    func getEmail() -> String {
        return profileProvider.profile.email
    }
    
    func getName() -> String {
        return profileProvider.profile.name
    }
    
    func onTapAction(_ action: TAction) {
        presenter?.completion?(action)
        presenter?.isOpened = false
    }
    
    func updateCells() {
        presenter?.setCells(construct())
    }
}

// MARK: - Factory
extension NavigationDrawerInteractorImpl {
    
    private func construct() -> [NavigationDrawerCellModel] {
        var cells = [NavigationDrawerCellModel]()
        cells.append(NavigationDrawerCellModelBuilder()
            .setTitle(Locales.value("navigationDrawer_app"))
            .setAction(.app)
            .setIcon(Assets.shared.drawerApp)
            .build())
        cells.append(NavigationDrawerCellModelBuilder()
            .setTitle(Locales.value("navigationDrawer_policy"))
            .setAction(.policy)
            .setIcon(Assets.shared.drawerPolicy)
            .build())
        return cells
    }
}
