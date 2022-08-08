//
//  SignUpInteractor.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

import Foundation
import Combine

protocol SignUpInteractor: AnyObject {
    func onTapSignUp(login: String, password: String, confirmPassword: String)
}

final class SignUpInteractorImpl: SignUpInteractor {
    private var signUpProvider: SignUpProvider
    private var signUpRequestCancellable: AnyCancellable?
    weak var presenter: SignUpPresenter?
    
    init(signUpProvider: SignUpProvider) {
        self.signUpProvider = signUpProvider
    }
    
    func onTapSignUp(login: String, password: String, confirmPassword: String) {
        guard login.isValidEmail, password.isValidPassword, confirmPassword.isValidPassword else {
            if !login.isValidEmail {
                presenter?.showErrorLogin()
            }
            if !password.isValidPin {
                presenter?.showErrorPassword()
            }
            if !confirmPassword.isValidPassword {
                presenter?.showErrorConfirmPassword()
            }
            return
        }
        
        signUpRequestCancellable = signUpProvider.signUp(with: SignUpCredentials(login: login, password: password, name: ""))
            .sink(receiveValue: { [weak self] isAuthed, message in
                if !isAuthed {
                }
                else {
                    self?.presenter?.onSignUp?(false)
                }
            })
    }
}
