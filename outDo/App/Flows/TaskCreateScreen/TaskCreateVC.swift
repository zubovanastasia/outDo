//
//  TaskCreateVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 26.08.2022.
//

import UIKit

enum TTaskCreateField {
    case title, date, desc
}

protocol TaskCreateView: AnyObject {
    
    func setTitle(_ value: String)
    func setTitleSave(_ value: String)
    func setPlaceholder(_ value: String, for textifeld: TTaskCreateField)
    func setTextfield(_ value: String, for textifeld: TTaskCreateField)
}

final class TaskCreateVC: UIViewController, TaskCreateView {

    // MARK: - Properties
    var presenter: TaskCreatePresenter
    
    // MARK: - Outlets
    @IBOutlet private weak var titleTextfield: UITextField!
    @IBOutlet private weak var textviewBgView: UIView!
    @IBOutlet private weak var dateTextfield: UITextField!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var textviewPromptLabel: UILabel!
    private var saveButton: UIButton!
    
    // MARK: - View
    init(presenter: TaskCreatePresenter) {
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
    
    private func configure() {
        saveButton = UIButton(type: .custom)
        saveButton.style = Styles.shared.button.quietSmNavbar
        saveButton.addTarget(self, action: #selector(onTapSave), for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: saveButton)
        ]
        
        titleTextfield.style = Styles.shared.tfs.odPrT
        dateTextfield.style = Styles.shared.tfs.odPrM
        textviewBgView.style = Styles.shared.tfs.odPrB
        textView.style = Styles.shared.tfs.odPr
        textviewPromptLabel.style = Styles.shared.tfs.odPh
    }
    
    private func addGestures() {
        var tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(onTapDate))
        tap.cancelsTouchesInView = false
        dateTextfield.addGestureRecognizer(tap)
    }
    
    // MARK: - Data
    func updateData() {
        presenter.updateData()
    }
    
    // MARK: - Keyboard
    @objc func keyboardDismiss() {
        self.view.endEditing(true)
    }
    
    // MARK: - Taps
    @objc private func onTapDate() {
        presenter.onTapDate()
        keyboardDismiss()
    }
    
    @objc private func onTapSave() {
        presenter.onTapSave()
    }
    
    // MARK: - Textfield
    @IBAction func onEditingDidBegin(_ sender: UITextField) {
        sender.showTfOdFocused()
        self.view.addSubview(sender)
    }
    
    @IBAction func onEditingDidEnd(_ sender: UITextField) {
        sender.showTfOdUp()
    }
    
    @IBAction func onDidChangeTitle(_ sender: UITextField) {
        guard let text = sender.text else { return }
        presenter.onDidChangeTitle(text)
    }
}

// MARK: - TaskCreateView
extension TaskCreateVC {
    
    func setTitle(_ value: String) {
        self.title = value
    }
    
    func setTitleSave(_ value: String) {
        saveButton.setTitle(value, for: .normal)
    }
    
    func setPlaceholder(_ value: String, for textfield: TTaskCreateField) {
        switch textfield {
        case .title:
            titleTextfield.setPlaceholer(value, with: Styles.shared.tfs.odPh)
        case .date:
            dateTextfield.setPlaceholer(value, with: Styles.shared.tfs.odPh)
        case .desc:
            textviewPromptLabel.text = value
        }
    }
    
    func setTextfield(_ value: String, for textfield: TTaskCreateField) {
        switch textfield {
        case .title:
            titleTextfield.text = value
        case .date:
            dateTextfield.text = value
        case .desc:
            textView.text = value
        }
    }
}

// MARK: - Gestures
extension TaskCreateVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !textviewBgView.bounds.contains(touch.location(in: textviewBgView))
    }
}


// MARK: - Textfield
extension TaskCreateVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textviewBgView.showTfOdFocused()
        self.view?.addSubview(textviewBgView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textviewBgView.showTfOdUp()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        presenter.onDidChangeText(textView.text)
        UIView.animate(withDuration: 0.1) {
            self.textviewPromptLabel.alpha = self.textView.text.count == 0 ? 1 : 0
        }
    }
}
