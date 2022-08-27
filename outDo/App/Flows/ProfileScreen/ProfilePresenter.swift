//
//  ProfilePresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import Foundation
import UIKit

protocol ProfilePresenter: AnyObject {

    // MARK: - Coordinator
    var onBack: VoidClosure? { get set }
    var onSignOut: VoidClosure? { get set }

    func onTapSignOut()
    func updateData()
}

final class ProfilePresenterImpl: ProfilePresenter {
    
    // MARK: - Coordinator
    var onBack: VoidClosure?
    var onSignOut: VoidClosure?
    
    private var interactor: ProfileInteractor
    weak var view: (UIViewController & ProfileView)?
    
    init(interactor: ProfileInteractor) {
        self.interactor = interactor
    }
    
    func onTapSignOut() {
        interactor.onTapSignOut()
    }
    
    func updateData() {
        view?.setTitle(Locales.value("vc_profile_title"))
        view?.setTitleButton(Locales.value("vc_profile_signOut"))
        view?.setPlaceholder(Locales.value("vc_profile_name"), for: .name)
        view?.setPlaceholder(Locales.value("vc_profile_email"), for: .email)
        view?.setTextfield(interactor.getName(), for: .name)
        view?.setTextfield(interactor.getEmail(), for: .email)
    }
}

