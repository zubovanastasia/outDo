//
//  LoginInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation
import Combine

protocol LoginInteractor: AnyObject {
    
    func onTapSignIn(login: String, password: String)
    func onTapSignUp()
}

final class LoginInteractorImpl: LoginInteractor {
 
    private var authProvider: AuthProvider
    private var authRequestCancellable: AnyCancellable?
    
    weak var presenter: LoginPresenter?
    
    init(authProvider: AuthProvider) {
        self.authProvider = authProvider
    }
    
    func onTapSignIn(login: String, password: String) {
        guard login.isValidEmail, password.isValidPassword else {
            // TODO: Show Toast
            //DialogBuilder.shared.showToast(Locales.value("dialog_text_wrongLoginPassword"))
            if !login.isValidEmail {
                presenter?.showErrorLogin()
            }
            if !password.isValidPin {
                presenter?.showErrorPassword()
            }
            return
        }
        
        authRequestCancellable = authProvider.signIn(with: AuthCredentials(login: login, password: password))
            .sink(receiveValue: { [weak self] isAuthed, message in
                if !isAuthed {
                    // TODO: Show Alert
//                    DialogBuilder.shared.showAlert(AlertData(
//                        title: Locales.value("dialog_title_auth"),
//                        text: message ?? "",
//                        buttons: [
//                            AlertButtonData(
//                                title: Locales.value("dialog_button_close"),
//                                completion: nil)]
//                        ))
                }
                else {
                    self?.presenter?.onSignIn?()
                }
            })
    }
    
    func onTapSignUp() {
        presenter?.onSignUp?()
    }
}

