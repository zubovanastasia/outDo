//
//  ProfileInteracotr.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import Foundation
import Combine

protocol ProfileInteractor: AnyObject {
    
    func onTapEditImage(image: String?)
    func onTapEditProfile(name: String)
}

final class ProfileInteractorImpl: ProfileInteractor {
    private var authProvider: AuthProvider
    private var profileProvider: ProfileProvider
    private var authRequestCancellable: AnyCancellable?
    
    weak var presenter: ProfilePresenter?
    
    init(authProvider: AuthProvider, profileProvider: ProfileProvider) {
        self.authProvider = authProvider
        self.profileProvider = profileProvider
    }
    
    func onTapEditImage(image: String?) {
        presenter?.onEditImage?()
    }
    
    func onTapEditProfile(name: String) {
        presenter?.onEditProfile?()
    }
}

