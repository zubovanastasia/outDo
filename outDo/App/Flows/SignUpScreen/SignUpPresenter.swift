//
//  SignUpPresenter.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

import Foundation
import UIKit

protocol SignUpPresenter: AnyObject{
    // MARK: - Coordinator
    var onSignUp: BoolClosure? { get set }
    
    func onTapSignUp(login: String, password: String, confirmPassword: String)
    func showErrorLogin()
    func showErrorPassword()
    func showErrorConfirmPassword()
    func updateData()
}

final class SignUpPresenterImpl: SignUpPresenter {
    // MARK: - Coordinator
    var onSignUp: BoolClosure?
    private var interactor: SignUpInteractor
    weak var view: (UIViewController & SignUpView)?
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    // MARK: - Public methods.
    func onTapSignUp(login: String, password: String, confirmPassword: String) {
        interactor.onTapSignUp(
            login: login,
            password: password,
            confirmPassword: confirmPassword)
    }
    func showErrorLogin() {
        view?.showErrorLogin()
    }
    func showErrorPassword() {
        view?.showErrorPassword()
    }
    func showErrorConfirmPassword() {
        view?.showErrorConfirmPassword()
    }
    func updateData() {
        view?.setPlaceholderLogin(Locales.value(""))
        view?.setPlaceholderPassword(Locales.value(""))
        view?.setPlaceholderConfirmPassword(Locales.value(""))
        view?.setTitleSignUp(Locales.value(""))
    }
}
