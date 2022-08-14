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
            // TODO: Toast
            return
        }
        
        guard credentials.login.isValidEmail else {
            presenter?.showError(for: .login)
            // TODO: Toast
            return
        }
                  
        guard credentials.password.isValidPassword else {
            presenter?.showError(for: .password)
            // TODO: Toast
            return
        }
        
        guard credentials.password == confirmPassword else {
            presenter?.showError(for: .confirm)
            // TODO: toast
            return
        }
        
        signUpRequestCancellable = signUpProvider.signUp(with: credentials)
            .sink(receiveValue: { [weak self] isSuccess, message in
                if isSuccess {
                    self?.presenter?.onSignUp()
                    // TODO: toast message
                }
                else {
                    // TODO: toast message
                }
            })
    }
}
