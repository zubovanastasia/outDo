//
//  LoginPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation
import UIKit

protocol LoginPresenter: AnyObject {
    
    // MARK: - Coordinator
    var onSignIn: VoidClosure? { get set }
    var onSignUp: VoidClosure? { get set }
    
    func onTapSignIn(login: String, password: String)
    func onTapSignUp()
    func showErrorLogin()
    func showErrorPassword()
    func updateData()
}

final class LoginPresenterImpl: LoginPresenter {
    
    // MARK: - Coordinator
    var onSignIn: VoidClosure?
    var onSignUp: VoidClosure?
    
    private var interactor: LoginInteractor
    weak var view: (UIViewController & LoginView)?
    
    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }
    
    func onTapSignIn(login: String, password: String) {
        interactor.onTapSignIn(
            login: login,
            password: password)
    }
    
    func onTapSignUp() {
        interactor.onTapSignUp()
    }
    
    func showErrorLogin() {
        view?.showErrorLogin()
    }
    
    func showErrorPassword() {
        view?.showErrorPassword()
    }
    
    func updateData() {
        view?.setPlaceholderLogin(Locales.value("vc_login_login"))
        view?.setPlaceholderPassword(Locales.value("vc_login_password"))
        view?.setTitleSignIn(Locales.value("vc_login_signIn"))
    }
}

