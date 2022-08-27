//
//  DatePickerPopup.swift
//  outDo
//
//  Created by Антон Бондаренко on 27.08.2022.
//

import UIKit

protocol DatePickerView: AnyObject {
    
    func setDate(_ value: Date, animated: Bool)
    func setMinimumDate(_ value: Date)
    func setTitle(_ value: String)
    func setTitleButtonApply(_ value: String)
    func setTitleButtonCancel(_ value: String)
}

final class DatePickerPopup: UIViewController, DatePickerView {

    // MARK: - Outlets
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var applyButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    // MARK: - Constraints
    @IBOutlet private weak var cHeight: NSLayoutConstraint!
    
    
    // MARK: - Properties
    var presenter: DatePickerPresenter

    
    // MARK: - View
    init(presenter: DatePickerPresenter) {
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    // MARK: - Private
    private func configure() {
        cHeight.constant = 264 + Styles.shared.view.bottomInset
        //fix width bug
        self.view.frame = CGRect(x: 0, y: 0, width: Styles.shared.view.screenWidth, height: cHeight.constant)
        
        datePicker.locale = Locale(identifier: Locales.currentShort)
        datePicker.backgroundColor = UIColor.clear
        datePicker.timeZone = NSTimeZone.local
        datePicker.minuteInterval = 5
        presenter.initMinimumDate()
        presenter.initDate()
        
        contentView.style = Styles.shared.view.popupT
        titleLabel.style = Styles.shared.label.b22main
        applyButton.style = Styles.shared.button.bevelSmPr
        cancelButton.style = Styles.shared.button.bevelSmSc
    }
    
    // MARK: - Data
    func updateData() {
        presenter.updateData()
    }
    
    // MARK: - Taps
    @IBAction private func onTapApply(_ sender: UIButton) {
        presenter.onTapApply(datePicker.date)
    }
    
    @IBAction private func onTapCancel(_ sender: UIButton) {
        presenter.onTapCancel()
    }
}

// MARK: - DatePickerView
extension DatePickerPopup {
    
    func setDate(_ value: Date, animated: Bool) {
        datePicker.setDate(value, animated: animated)
    }
    
    func setMinimumDate(_ value: Date) {
        datePicker.minimumDate = value
    }
    
    func setTitle(_ value: String) {
        titleLabel.text = value
    }
    
    func setTitleButtonApply(_ value: String) {
        applyButton.setTitle(value, for: .normal)
    }
    
    func setTitleButtonCancel(_ value: String) {
        cancelButton.setTitle(value, for: .normal)
    }
}

// MARK: - Gesture Delegate
extension DatePickerPopup: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !contentView.bounds.contains(touch.location(in: contentView))
    }
}
