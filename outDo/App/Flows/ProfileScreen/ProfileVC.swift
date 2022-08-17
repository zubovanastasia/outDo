//
//  ProfileVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

protocol ProfileView {
    func setTitleName(_ value: String)
    func setTitleEditImage(_ value: String)
    func setTitleEditProfile(_ value: String)
    func setTitleEmail(_ value: String)
}
final class ProfileVC: UIViewController, ProfileView {
    var presenter: ProfilePresenter
    var model = Profile()
    
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
        updateData(model)
    }
    
    // MARK: - Private
    private func configure() {
    }
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    func updateData(_ data: Profile) {
        avaImage.image = !data.icon.isEmpty ? UIImage(named: data.icon) : nil
        emailLabel.text = data.email
        nameTextField.placeholder = data.name
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
    func setTitleEditImage(_ value: String) {
        editImage.setTitle(value, for: .normal)
    }
    func setTitleName(_ value: String) {
        nameTextField.setPlaceholer(value, with: Styles.shared.tfs.odPh)
    }
    func setTitleEditProfile(_ value: String) {
        editProfile.setTitle(value, for: .normal)
    }
    func setTitleEmail(_ value: String) {
        emailLabel.text = value
    }
}
