//
//  ProfileInteracotr.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import Foundation

protocol ProfileInteractor: AnyObject {
    
    func getEmail() -> String
    func getName() -> String
    func onTapSignOut()
}

final class ProfileInteractorImpl: ProfileInteractor {
    
    private var authProvider: AuthProvider
    private var profileProvider: ProfileProvider
    
    weak var presenter: ProfilePresenter?
    
    init(authProvider: AuthProvider, profileProvider: ProfileProvider) {
        self.authProvider = authProvider
        self.profileProvider = profileProvider
    }

    func getEmail() -> String {
        return profileProvider.profile.email
    }
    
    func getName() -> String {
        return profileProvider.profile.name
    }
    
    func onTapSignOut() {
        DialogBuilder.shared.showAlert(AlertData(
            title: Locales.value("alert_title_auth"),
            text: Locales.value("alert_text_signOut"),
            buttons: [
                AlertButtonData(
                    title: Locales.value("dialog_button_no"),
                    completion: nil),
                AlertButtonData(
                    title: Locales.value("dialog_button_yesSignOut"),
                    completion: { [weak self] in
                        self?.authProvider.signOut()
                        self?.presenter?.onSignOut?()
                    })]
            ))
    }
}
