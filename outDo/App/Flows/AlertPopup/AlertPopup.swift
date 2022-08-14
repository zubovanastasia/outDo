//
//  AlertPopup.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class AlertPopup: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    
    // MARK: - Constraints
    @IBOutlet private weak var cWidth: NSLayoutConstraint!
    
    // MARK: - Properties
    private var deviceProvider: DeviceProvider
    private var data: AlertData
    
    // MARK: - View
    init(data: AlertData, deviceProvider: DeviceProvider) {
        self.data = data
        self.deviceProvider = deviceProvider
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DialogBuilder.shared.remove(self)
    }
    
    func hide() {
        DialogBuilder.shared.remove(self, animated: true)
    }
    
    // MARK: - Private
    private func configure() {
        // fix size
        self.view.frame = UIScreen.main.bounds
        cWidth.constant = deviceProvider.isIpad ? Styles.shared.view.screenWidth / 2 : Styles.shared.view.screenWidth - 80
        
        contentView.style = Styles.shared.view.popup
        titleLabel.style = Styles.shared.label.b20mainC
        textLabel.style = Styles.shared.label.r18main
        leftButton.style = Styles.shared.button.dialogDfSc
        rightButton.style = Styles.shared.button.dialogDfPr
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Data
    func updateData() {
        titleLabel.text = data.title
        textLabel.text = data.text
        // buttons
        if data.buttons.count > 0 {
            leftButton.setTitle(data.buttons.first?.title ?? "", for: .normal)
        }
        if data.buttons.count > 1 {
            rightButton.setTitle(data.buttons.last?.title ?? "", for: .normal)
        }
        else {
            rightButton.removeFromSuperview()
        }
    }
    
    // MARK: - Taps
    @IBAction private func onTapLeft(_ sender: UIButton) {
        self.onHandleCancel()
    }
    
    @IBAction private func onTapRight(_ sender: UIButton) {
        self.onHandleApply()
    }
    
    @objc private func onTapView() {
        self.onHandleCancel()
    }
}

// MARK: - Gesture
extension AlertPopup: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !contentView.bounds.contains(touch.location(in: contentView))
    }
}

// MARK: - Handle
extension AlertPopup {
    
    func onHandleApply() {
        data.buttons.last?.completion?()
        hide()
    }
    
    func onHandleCancel() {
        data.buttons.first?.completion?()
        hide()
    }
}
