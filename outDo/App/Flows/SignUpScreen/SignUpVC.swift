//
//  SignUpVC.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

import UIKit
import Combine

protocol SignUpView {
    func setPlaceholderLogin(_ value: String)
    func setPlaceholderPassword(_ value: String)
    func setPlaceholderConfirmPassword(_ value: String)
    func setTitleSignUp(_ value: String)
    func showErrorLogin()
    func showErrorPassword()
    func showErrorConfirmPassword()
}

final class SignUpVC: UIViewController, SignUpView {
    // MARK: - Properties
    var presenter: SignUpPresenter
    
    // MARK: - Outlets
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    
    // MARK: - View
    init(presenter: SignUpPresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addGestures()
        updateData()
    }
    
    // MARK: - Private methods
    private func configure() {
        self.view.backgroundColor = Styles.shared.c.vc
        loginTextField.style = Styles.shared.tfs.olPrT
        passwordTextField.style = Styles.shared.tfs.olPrB
        confirmPasswordTextField.style = Styles.shared.tfs.olPrB
        signUpButton.style = Styles.shared.button.bevelDfPr
    }
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Data
    func updateData() {
        presenter.updateData()
    }
    
    // MARK: - Taps
    @IBAction private func onTapSignUp(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text
        else {
            return
        }
        presenter.onTapSignUp(
            login: login,
            password: password,
            confirmPassword: confirmPassword)
    }
}

// MARK: - Extensions.
// - SignUpView.

extension SignUpVC {
    func setPlaceholderLogin(_ value: String) {
        loginTextField.setPlaceholer(value, with: Styles.shared.tfs.olPh)
    }
    func setPlaceholderPassword(_ value: String) {
        passwordTextField.setPlaceholer(value, with: Styles.shared.tfs.olPh)
    }
    func setPlaceholderConfirmPassword(_ value: String) {
        confirmPasswordTextField.setPlaceholer(value, with: Styles.shared.tfs.olPh)
    }
    func setTitleSignUp(_ value: String) {
        signUpButton.setTitle(value, for: .normal)
    }
    func showErrorLogin() {
        loginTextField.showTfOlError()
    }
    func showErrorPassword() {
        passwordTextField.showTfOlError()
    }
    func showErrorConfirmPassword() {
        confirmPasswordTextField.showTfOlError()
    }
}
// - Keyboard.
extension SignUpVC {
    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }
}
// - Textfield Delegate.
extension SignUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            loginTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        }
        else {
            confirmPasswordTextField.resignFirstResponder()
            onTapSignUp(signUpButton!)
        }
        return true
    }
}

