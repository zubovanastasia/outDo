//
//  ToastPopup.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

final class ToastPopup: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Constraints
    @IBOutlet private weak var cMaxWidth: NSLayoutConstraint!
    @IBOutlet private weak var cHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    private var timer = ScheduledTimer()
    private var message: String
    
    // MARK: - View
    init(message: String) {
        self.message = message
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer.start(delay: 3) {
            self.hide()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.stop()
        DialogBuilder.shared.remove(self)
    }
    
    func hide() {
        DialogBuilder.shared.remove(self, animated: true)
    }
    
    // MARK: - Private
    private func configure() {
        self.view.backgroundColor = .clear
        bgView.backgroundColor = .toast
        bgView.layer.cornerRadius = 30
        
        titleLabel.style = Styles.shared.label.r16ffffffC
        cMaxWidth.constant = Styles.shared.view.screenWidth - 40
        Styles.shared.addShadow(bgView, x: 0, y: 6, a: 0.2, blur: 10, cornerRadius: bgView.layer.cornerRadius)
    }
    
    private func addGestures() {
        var tap = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        tap.cancelsTouchesInView = false
        bgView.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Data
    func updateData() {
        guard let _ = titleLabel else { return }
        titleLabel.text = message
        updateSize()
    }
    
    private func updateSize() {
        let size = titleLabel.text!.getTextSize(width: cMaxWidth.constant - 50, font: titleLabel.font!)
        var height = ceil(size.height) + 32
        if height < 60 { height = 60 }
        let newWidth: CGFloat = max(ceil(size.width) + 50, 150)
        self.view.frame = CGRect(x: 0, y: 0, width: newWidth, height: height)
        bgView.frame = self.view.frame
        bgView.layer.shadowPath = UIBezierPath(roundedRect: bgView.bounds, cornerRadius: bgView.layer.cornerRadius).cgPath
    }
    
    // MARK: - Taps
    @objc private func onTapView(sender: UITapGestureRecognizer) {
        hide()
    }
}

