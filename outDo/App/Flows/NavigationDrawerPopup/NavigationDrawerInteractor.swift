//
//  NavigationDrawerInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

protocol NavigationDrawerInteractor: AnyObject {
    
}

final class NavigationDrawerInteractorImpl: NavigationDrawerInteractor {
    
    weak var presenter: NavigationDrawerPresenter?
    private let profileProvider: ProfileProvider
    
    init(profileProvider: ProfileProvider) {
        self.profileProvider = profileProvider
    }
}
