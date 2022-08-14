//
//  LoginVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit
import Combine

protocol LoginView {
    
    func setPlaceholderLogin(_ value: String)
    func setPlaceholderPassword(_ value: String)
    func setTitleSignIn(_ value: String)
    func showErrorLogin()
    func showErrorPassword()
}

final class LoginVC: UIViewController, LoginView {

    // MARK: - Properties
    var presenter: LoginPresenter
        
    // MARK: - Outlets
    @IBOutlet private weak var loginTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    // MARK: - View
    init(presenter: LoginPresenter) {
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
    
    // MARK: - Private
    private func configure() {
        self.view.backgroundColor = Styles.shared.color.vc
        loginTextfield.style = Styles.shared.tfs.odPrT
        passwordTextfield.style = Styles.shared.tfs.odPrB
        signInButton.style = Styles.shared.button.bevelDfSc
        signUpButton.style = Styles.shared.button.quietDfSc
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
    @IBAction private func onTapSignIn(_ sender: UIButton) {
        guard let login = loginTextfield.text,
              let password = passwordTextfield.text
        else { return }
        presenter.onTapSignIn(
            login: login,
            password: password)
    }
    
    @IBAction func onTapSignUp(_ sender: UIButton) {
        presenter.onTapSignUp()
    }
    
    // MARK: - Textfield
    @IBAction private func onEditingDidBegin(_ sender: UITextField) {
        sender.showTfOdFocused()
        sender.superview?.addSubview(sender)
    }
    
    @IBAction private func onEditingDidEnd(_ sender: UITextField) {
        sender.showTfOdUp()
    }
}

// MARK: - LoginView
extension LoginVC {
    
    func setPlaceholderLogin(_ value: String) {
        loginTextfield.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
    
    func setPlaceholderPassword(_ value: String) {
        passwordTextfield.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
    
    func setTitleSignIn(_ value: String) {
        signInButton.setTitle(value, for: .normal)
    }
    
    func showErrorLogin() {
        loginTextfield.showTfOdError()
    }
    
    func showErrorPassword() {
        passwordTextfield.showTfOdError()
    }
}

// MARK: - Keyboard
extension LoginVC {

    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }
}

// MARK: Textfield Delegate
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextfield {
            loginTextfield.resignFirstResponder()
            passwordTextfield.becomeFirstResponder()
        }
        else {
            passwordTextfield.resignFirstResponder()
            onTapSignIn(signInButton)
        }
        return true
    }
}

