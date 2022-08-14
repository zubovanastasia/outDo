//
//  SignUpVC.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

import UIKit
import Combine

enum TSignUpTextField {
    case name, login, password, confirm
}

protocol SignUpView {
    
    func setPlaceholder(_ value: String, for textfield: TSignUpTextField)
    func showError(for textfield: TSignUpTextField)
    
//    func setPlaceholderLogin(_ value: String)
//    func setPlaceholderName(_ value: String)
//    func setPlaceholderPassword(_ value: String)
//    func setPlaceholderConfirmPassword(_ value: String)
    func setTitleSignUp(_ value: String)
//    func showErrorLogin()
//    func showErrorName()
//    func showErrorPassword()
//    func showErrorConfirmPassword()
}

final class SignUpVC: UIViewController, SignUpView {
    
    // MARK: - Outlets
    @IBOutlet private weak var nameTextField: UITextField!
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear(isMovingFromParent)
    }
    
    // MARK: - Private methods
    private func configure() {
        self.view.backgroundColor = Styles.shared.color.vc
        nameTextField.style = Styles.shared.tfs.odPrT
        loginTextField.style = Styles.shared.tfs.odPrM
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
        guard let name = nameTextField.text,
              let login = loginTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text
        else { return }
        presenter.onTapSignUp(
            credentials: SignUpCredentials(
                login: login,
                password: password,
                name: name),
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
    
    func setPlaceholder(_ value: String, for textfield: TSignUpTextField) {
        let input: UITextField
        switch textfield {
        case .name:
            input = nameTextField
        case .login:
            input = loginTextField
        case .password:
            input = passwordTextField
        case .confirm:
            input = confirmPasswordTextField
        }
        input.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
        
    func setTitleSignUp(_ value: String) {
        signUpButton.setTitle(value, for: .normal)
    }
    
    func showError(for textfield: TSignUpTextField) {
        let input: UITextField
        switch textfield {
        case .name:
            input = nameTextField
        case .login:
            input = loginTextField
        case .password:
            input = passwordTextField
        case .confirm:
            input = confirmPasswordTextField
        }
        input.showTfOdError()
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

