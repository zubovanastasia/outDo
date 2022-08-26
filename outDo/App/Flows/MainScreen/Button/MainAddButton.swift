//
//  MainVC.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

import UIKit

final class MainAddButton: UIView {
    
    // MARK: - Outlets
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: Styles.shared.button.sizeDf, height: Styles.shared.button.sizeDf))
        button.style = Styles.shared.button.circleDfPlus
        Styles.shared.addShadow(self, x: 2, y: 2, a: 0.4, blur: 2, cornerRadius: button.layer.cornerRadius)
        button.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    var onTap: VoidClosure?
    
    
    // MARK: - View
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Private
    private func configure() {
        self.backgroundColor = .clear
        self.addSubview(button)
    }
    
    // MARK: - Public
    func show() {
        self.layer.removeAllAnimations()
        self.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
    func hide() {
        self.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
        }
    }
    
    // MARK: - Taps
    @objc private func onTapButton() {
        onTap?()
    }
}
