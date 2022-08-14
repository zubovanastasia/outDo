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
  
    // MARK: - Outlets
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    
    // MARK: - Properties
    var presenter: SignUpPresenter
    
    
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
        self.view.backgroundColor = Styles.shared.color.vc
        loginTextField.style = Styles.shared.tfs.odPrT
        passwordTextField.style = Styles.shared.tfs.odPrM
        confirmPasswordTextField.style = Styles.shared.tfs.odPrB
        signUpButton.style = Styles.shared.button.bevelDfSc
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
    @IBAction private func onTapSignUp(_ sender: UIButton) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text
        else { return }
        presenter.onTapSignUp(
            login: login,
            password: password,
            confirmPassword: confirmPassword)
    }
    
    // MARK: - Textfield
    @IBAction func onEditingDidBegin(_ sender: UITextField) {
        sender.showTfOdFocused()
        sender.superview?.addSubview(sender)
    }
    
    @IBAction func onEditingDidEnd(_ sender: UITextField) {
        sender.showTfOdUp()
    }
}

// MARK: - SignUpView.
extension SignUpVC {
    
    func setPlaceholderLogin(_ value: String) {
        loginTextField.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
    
    func setPlaceholderPassword(_ value: String) {
        passwordTextField.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
    
    func setPlaceholderConfirmPassword(_ value: String) {
        confirmPasswordTextField.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
    
    func setTitleSignUp(_ value: String) {
        signUpButton.setTitle(value, for: .normal)
    }
    
    func showErrorLogin() {
        loginTextField.showTfOdError()
    }
    
    func showErrorPassword() {
        passwordTextField.showTfOdError()
    }
    
    func showErrorConfirmPassword() {
        confirmPasswordTextField.showTfOdError()
    }
}

// MARK: - Keyboard.
extension SignUpVC {

    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }
}

// MARK: - Textfield Delegate
extension SignUpVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            loginTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        }
        else {
            confirmPasswordTextField.resignFirstResponder()
            onTapSignUp(signUpButton)
        }
        return true
    }
}

