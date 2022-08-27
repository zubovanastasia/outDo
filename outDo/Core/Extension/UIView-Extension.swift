//
//  UIView-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width:CGFloat, height: CGFloat) {
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    private func animateState(_ borderColor: UIColor, _ bgColor: UIColor) {
        self.layer.animateBorderColor(to: borderColor)
        self.layer.animateBgColor(to: bgColor)
    }
    
    func showTfOdUp() {
        self.animateState(.tfOdBorderUp, .tfOdBgUp)
    }
    
    func showTfOdFocused() {
        self.animateState(.tfOdBorderFocused, .tfOdBgFocused)
    }
    
    func showTfOdError() {
        self.animateState(.tfOdBorderError, .tfOdBgError)
    }
    
    func showTfOlUp() {
        self.animateState(.tfOlBorderUp, .tfOlBgUp)
    }
    
    func showTfOlFocused() {
        self.animateState(.tfOlBorderFocused, .tfOlBgFocused)
    }
    
    func showTfOlError() {
        self.animateState(.tfOlBorderError, .tfOlBgError)
    }
    
    func setLeftTopCornerRadius(value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMinXMinYCorner]
    }
    
    func setLeftBottomCornerRadius(value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func setLeftCornerRadius(value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func setRightCornerRadius(value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func setRightTopCornerRadius(value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    
    func setRightBottomCornerRadius(value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    func setTopCornerRadius(value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setBottomCornerRadius(value: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = value
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func applyStyle(style: String) {
        Styles.shared.applyStyle(style, self)
    }
    
    var style: String {
        get { return "" }
        set { Styles.shared.applyStyle(newValue, self) }
    }
}
