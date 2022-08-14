//
//  SignUpInteractor.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

import Foundation
import Combine

protocol SignUpInteractor: AnyObject {
    
    func onTapSignUp(credentials: SignUpCredentials, confirmPassword: String)
}

final class SignUpInteractorImpl: SignUpInteractor {
    
    private var signUpProvider: SignUpProvider
    private var signUpRequestCancellable: AnyCancellable?
    weak var presenter: SignUpPresenter?
    
    init(signUpProvider: SignUpProvider) {
        self.signUpProvider = signUpProvider
    }
    
    func onTapSignUp(credentials: SignUpCredentials, confirmPassword: String) {
        guard !credentials.name.isEmpty else {
            presenter?.showError(for: .name)
            DialogBuilder.shared.showToast(Locales.value("toast_signUpWrongName"))
            return
        }
        
        guard credentials.login.isValidEmail else {
            presenter?.showError(for: .login)
            DialogBuilder.shared.showToast(Locales.value("toast_signUpWrongLogin"))
            return
        }
                  
        guard credentials.password.isValidPassword else {
            presenter?.showError(for: .password)
            DialogBuilder.shared.showToast(Locales.value("toast_signUpWrongPassword"))
            return
        }
        
        guard credentials.password == confirmPassword else {
            presenter?.showError(for: .confirm)
            DialogBuilder.shared.showToast(Locales.value("toast_signUpWrongConfirm"))
            return
        }
        
        signUpRequestCancellable = signUpProvider.signUp(with: credentials)
            .sink(receiveValue: { [weak self] isSuccess, message in
                if isSuccess {
                    self?.presenter?.onSignUp()
                    DialogBuilder.shared.showAlert(AlertData(
                        title: Locales.value("alert_title_auth"),
                        text: message ?? Locales.value("alert_text_signUpSuccess"),
                        buttons: [
                            AlertButtonData(
                                title: Locales.value("dialog_button_close"),
                                completion: nil)]
                        ))
                }
                else if let message = message {
                    DialogBuilder.shared.showToast(message)
                }
            })
    }
}
