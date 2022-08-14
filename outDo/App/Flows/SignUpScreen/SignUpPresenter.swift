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
    var onBack: VoidClosure? { get set }
    
    func onTapSignUp(credentials: SignUpCredentials, confirmPassword: String)
    func onSignUp()
    func showError(for textfield: TSignUpTextField)
    func updateData()
    func viewWillDisappear(_ isMovingFromParent: Bool)
}

final class SignUpPresenterImpl: SignUpPresenter {
   
    // MARK: - Coordinator
    var onBack: VoidClosure?
    
    private var interactor: SignUpInteractor
    weak var view: (UIViewController & SignUpView)?
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    func onSignUp() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func onTapSignUp(credentials: SignUpCredentials, confirmPassword: String) {
        interactor.onTapSignUp(
            credentials: credentials,
            confirmPassword: confirmPassword)
    }
    
    func showError(for textfield: TSignUpTextField) {
        view?.showError(for: textfield)
    }
    
    func updateData() {
        view?.setPlaceholder(Locales.value("vc_signUp_name"), for: .name)
        view?.setPlaceholder(Locales.value("vc_signUp_login"), for: .login)
        view?.setPlaceholder(Locales.value("vc_signUp_password"), for: .password)
        view?.setPlaceholder(Locales.value("vc_signUp_confirmPassword"), for: .confirm)
        view?.setTitleSignUp(Locales.value("vc_signUp_button"))
    }
    
    func viewWillDisappear(_ isMovingFromParent: Bool) {
        if isMovingFromParent {
            self.onBack?()
        }
    }
}
