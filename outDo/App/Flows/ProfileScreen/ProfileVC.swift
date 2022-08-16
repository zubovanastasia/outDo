//
//  ProfileVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

protocol ProfileView {
    func setPlaceholderName(_ value: String)
    func setTitleEditImage(_ value: String)
    func setTitleEditProfile(_ value: String)
}
final class ProfileVC: UIViewController, ProfileView {
    var presenter: ProfilePresenter
    
    // MARK: - Outlets
    @IBOutlet private weak var avaImage: UIImageView!
    @IBOutlet private weak var editImage: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var editProfile: UIButton!
    
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
        self.title = "Профиль"
        configure()
        addGestures()
        updateData()
    }
    
    // MARK: - Private
    private func configure() {
    }
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    func updateData() {
        presenter.updateData()
    }
    // MARK: - Taps
    @IBAction private func onTapEditImage(_ sender: Any) {
    }
    @IBAction private func onTapEditProfile(_ sender: Any) {
    }
    
    // MARK: - Navigation


}

// MARK: - Extensions
extension ProfileVC {
    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }
}
extension ProfileVC {
    func setPlaceholderName(_ value: String) {
        nameTextField.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
    
    func setTitleEditImage(_ value: String) {
        editImage.setTitle(value, for: .normal)
    }
    
    func setTitleEditProfile(_ value: String) {
        editProfile.setTitle(value, for: .normal)
    }
}
