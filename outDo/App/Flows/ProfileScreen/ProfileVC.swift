//
//  ProfileVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

enum TProfileTextfield {
    
    case name, email
}

protocol ProfileView {
    
    func setTitle(_ value: String)
    func setPlaceholder(_ value: String, for textfield: TProfileTextfield)
    func setTextfield(_ value: String, for textfield: TProfileTextfield)
    func setTitleButton(_ value: String)
}

final class ProfileVC: UIViewController, ProfileView {

    // MARK: - Properties
    var presenter: ProfilePresenter
    
    // MARK: - Outlets
    @IBOutlet private weak var avaImage: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var signOutButton: UIButton!
    
    // MARK: - View
    init(presenter: ProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateData()
    }
    
    // MARK: - Private
    private func configure() {
        nameTextField.style = Styles.shared.tfs.odPrT
        emailTextField.style = Styles.shared.tfs.odPrB
        signOutButton.style = Styles.shared.button.quietDfSc
    }
    
    // MARK: - Data
    func updateData() {
        presenter.updateData()
    }
    
    // MARK: - Taps
    @IBAction func onTapSignOut(_ sender: UIButton) {
        presenter.onTapSignOut()
    }
    
}

// MARK: - ProfileView
extension ProfileVC {
    
    func setTitle(_ value: String) {
        self.title = value
    }
    
    func setTitleButton(_ value: String) {
        signOutButton.setTitle(value, for: .normal)
    }
    
    func setPlaceholder(_ value: String, for textfield: TProfileTextfield) {
        let input: UITextField
        switch textfield {
        case .name:
            input = nameTextField
        case .email:
            input = emailTextField
        }
        input.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
    
    func setTextfield(_ value: String, for textfield: TProfileTextfield) {
        let input: UITextField
        switch textfield {
        case .name:
            input = nameTextField
        case .email:
            input = emailTextField
        }
        input.text = value
    }
}
