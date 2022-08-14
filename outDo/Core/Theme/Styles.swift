//
//  Theme.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//
//

import Foundation
import UIKit

struct MFont {
    
    var size: CGFloat
    var name: String
    var color: UIColor
    var ha: NSTextAlignment
    var adj: Bool
    var a: CGFloat
    
    init(_ size: CGFloat, _ name: String, _ color: UIColor, _ ha: NSTextAlignment, _ adj: Bool = false, _ a: CGFloat = 1.0) {
        self.size = size
        self.name = name
        self.color = color
        self.ha = ha
        self.adj = adj
        self.a = a
    }
}

final class Styles {
    
    static let shared = Styles()
    
    let button = ButtonStyles()
    let label = LabelStyles()
    let tfs = TextfieldStyles()
    let view = ViewStyles()
    
    let color = Colors()
    let fs = FontSizes()
    
    private let fontR = "SourceSansPro-Regular"
    private let fontB = "SourceSansPro-SemiBold"
    
    private var tf = [String:MFont]()
    private var tfFonts = [String:UIFont]()
    
    init() {
        tf[button.bevelDfPr] = MFont(fs.fs24, fontB, color.cffffff, NSTextAlignment.left)
        tf[button.bevelDfSc] = MFont(fs.fs24, fontB, color.c646464, NSTextAlignment.left)
        tf[button.bevelSmPr] = MFont(fs.fs20, fontB, color.cffffff, NSTextAlignment.left)
        tf[button.bevelSmSc] = MFont(fs.fs20, fontB, color.c646464, NSTextAlignment.left)
        tf[button.quietDfSc] = MFont(fs.fs24, fontB, color.cffffff, NSTextAlignment.left)
        tf[button.quietDfSc + "Down"] = MFont(fs.fs24, fontB, color.cffffff, NSTextAlignment.left, false, 0.7)
        tf[button.sharpLgPr] = MFont(fs.fs28, fontB, color.cffffff, NSTextAlignment.left)
        
        tf[label.r16ffffffC] = MFont(fs.fs16, fontR, color.cffffff, NSTextAlignment.center)
        tf[label.r18main] = MFont(fs.fs18, fontR, color.c000000, NSTextAlignment.left)
        tf[label.r20main] = MFont(fs.fs20, fontR, color.c000000, NSTextAlignment.left)
        tf[label.b20mainC] = MFont(fs.fs20, fontB, color.c000000, NSTextAlignment.center)
        tf[label.b229796a9] = MFont(fs.fs22, fontB, color.c9796a9, NSTextAlignment.center)
        tf[label.b22main] = MFont(fs.fs22, fontB, color.c000000, NSTextAlignment.left)
        
        tf[tfs.odPh] = MFont(fs.fs24, fontR, color.cffffff, NSTextAlignment.left, false, 0.4)
        tf[tfs.odPr] = MFont(fs.fs24, fontB, color.cffffff, NSTextAlignment.left)
        tf[tfs.olPh] = MFont(fs.fs24, fontR, color.c000000, NSTextAlignment.left, false, 0.4)
        tf[tfs.olPr] = MFont(fs.fs24, fontB, color.c000000, NSTextAlignment.left)

        tf[view.navbarPr] = MFont(fs.fs20, fontB, color.c000000, NSTextAlignment.left, false, 0.55)
        tf[view.navbarPrC] = MFont(fs.fs20, fontB, color.c000000, NSTextAlignment.center, false, 0.55)
    }
    
    func getFontStyle(_ style: String) -> MFont {
        return tf[style]!
    }
    
    func getFont(_ style: String) -> UIFont {
        let fontStyle = getFontStyle(style)
        let fontName = "\(fontStyle.name)\(fontStyle.size)"
        if tfFonts[fontName] == nil {
            tfFonts[fontName] = UIFont(name: fontStyle.name, size: fontStyle.size)
        }
        return tfFonts[fontName]!
    }
    
    func getFontColor(_ style: String) -> UIColor {
        let fontStyle = getFontStyle(style)
        return fontStyle.color.withAlphaComponent(fontStyle.a)
    }
    
    func applyStyle(_ style: String, _ button: UIButton) {
        self.button.applyStyle(style, button)
    }
    
    func applyStyle(_ style: String, _ barButtonItem: UIBarButtonItem) {
        self.button.applyStyle(style, barButtonItem)
    }
    
    func applyStyle(_ style: String, _ switchButton: UISwitch) {
        self.button.applyStyle(style, switchButton)
    }
    
    func applyStyle(_ style: String, _ label: UILabel) {
        self.label.applyStyle(style, label)
    }
    
    func applyStyle(_ style: String, _ textfield: UITextField) {
        self.tfs.applyStyle(style, textfield)
    }
    
    func applyStyle(_ style: String, _ textview: UITextView) {
        self.tfs.applyStyle(style, textview)
    }
    
    func applyStyle(_ style: String, _ view: UIView) {
        if view.isKind(of: UILabel.self) {
            self.applyStyle(style, view as! UILabel)
        }
        else if view.isKind(of: UIButton.self) {
            self.applyStyle(style, view as! UIButton)
        }
        else if view.isKind(of: UISwitch.self) {
            self.applyStyle(style, view as! UISwitch)
        }
        else if view.isKind(of: UITextField.self) {
            self.applyStyle(style, view as! UITextField)
        }
        else if view.isKind(of: UITextView.self) {
            self.applyStyle(style, view as! UITextView)
        }
        else {
            self.view.applyStyle(style, view)
        }
    }
    
    func getAttributedString(for string: String, with style: String) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: self.getAttributes(style))
    }
    
    func getAttributes(_ name: String) -> [NSAttributedString.Key: Any] {
        let font = tf[name]!
        return [
            NSAttributedString.Key.foregroundColor: font.color.withAlphaComponent(font.a),
            NSAttributedString.Key.font: UIFont(name: font.name, size: font.size)!
        ]
    }
   
    func addShadow(layer: CALayer, path: UIBezierPath, offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.shadowPath = path.cgPath
    }

    func addShadow(_ view: UIView, x: Double, y: Double, a: Double, blur: Double = 10.0, cornerRadius: CGFloat = 0) {
        if cornerRadius == 0 {
            addShadow(layer: view.layer, path: UIBezierPath(rect: view.bounds), offset: CGSize(width: x, height: y), color: .black, opacity: Float(a), radius: CGFloat(blur))
        }
        else {
            addShadow(layer: view.layer, path: UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius), offset: CGSize(width: x, height: y), color: .black, opacity: Float(a), radius: CGFloat(blur))
        }
    }
}

// MARK: - Colors
final class Colors {
    
    let dialogDark = UIColor(rgb: 0x000000, a: 0.3)
    let toast = UIColor(rgb: 0x333333)
    let vc = UIColor(rgb: 0xffffff)
    
    let fcMain = UIColor(rgb: 0x000000)
    
    let c000000 = UIColor(rgb: 0x000000)
    let c323232 = UIColor(rgb: 0x323232)
    let c514f65 = UIColor(rgb: 0x514f65)
    let c646464 = UIColor(rgb: 0x646464)
    let c969696 = UIColor(rgb: 0x969696)
    let c9796a9 = UIColor(rgb: 0x9796a9)
    let cffffff = UIColor(rgb: 0xffffff)

    let buttonPrUp = UIColor(rgb: 0x3d3c49)
    let buttonPrDown: UIColor
    let buttonPrDisabled: UIColor
    let buttonScUp = UIColor(rgb: 0xfafafa)
    let buttonScDown: UIColor
    let buttonFlowUp = UIColor(rgb: 0xffffff)
    let buttonFlowDown: UIColor
    let switchBgOn  = UIColor(rgb: 0x007aff)
    let switchBgOff = UIColor(rgb: 0xdcdcdc)
    let switchThumb  = UIColor(rgb: 0xffffff)
    let sep = UIColor(rgb: 0x000000, a: 0.09)
    
    let tfOdBorderUp = UIColor(rgb: 0xffffff)
    let tfOdBorderFocused = UIColor(rgb: 0xaaaaaa)
    let tfOdBorderError = UIColor(rgb: 0xf9b290)
    let tfOdBgUp = UIColor(rgb: 0xffffff, a: 0)
    let tfOdBgFocused = UIColor(rgb: 0xffffff, a: 0.05)
    let tfOdBgError = UIColor(rgb: 0xf9b290)
    
    let tfOlBorderUp = UIColor(rgb: 0xdddddd)
    let tfOlBorderFocused = UIColor(rgb: 0xdadada)
    let tfOlBorderError = UIColor(rgb: 0xf9b290)
    let tfOlBgUp = UIColor(rgb: 0xffffff, a: 0)
    let tfOlBgFocused = UIColor(rgb: 0xb3b34d, a: 0.05)
    let tfOlBgError = UIColor(rgb: 0xf9b290)
    
    init() {
        buttonPrDown = buttonPrUp.modified(additionalBrightness: -0.05)
        buttonPrDisabled = buttonPrUp.modified(additionalBrightness: 0.15)
        buttonScDown = buttonScUp.modified(additionalBrightness: -0.05)
        buttonFlowDown = buttonScUp.modified(additionalBrightness: -0.03)
    }
}

// MARK: - FontSizes
class FontSizes {
    
    let fs14: CGFloat  = 14.0
    let fs16: CGFloat = 16.0
    let fs18: CGFloat = 18.0
    let fs20: CGFloat = 20.0
    let fs22: CGFloat = 22.0
    let fs24: CGFloat = 24.0
    let fs26: CGFloat = 26.0
    let fs28: CGFloat = 28.0
    let fs40: CGFloat = 40.0
    let fs44: CGFloat = 44.0
}

// MARK: - Button
final class ButtonStyles {
    
    let bevelDfPr = "bevelDfPr"
    let bevelDfSc = "bevelDfSc"
    let bevelSmPr = "bevelSmPr"
    let bevelSmSc = "bevelSmSc"
    let dialogDfPr = "bevelDfPr"
    let dialogDfSc = "bevelDfSc"
    let circleDfPlus = "circleDfPlus"
    let quietDfSc = "quietDfSc"
    let sharpLgPr = "sharpLgPr"
    let swtch = "swtch"
    
    let sizeSm: CGFloat = 34
    let sizeDf: CGFloat = 50
    let sizeLg: CGFloat = 60
    let sizeFlow: CGFloat = 64
    
    let cornerDf: CGFloat = 10
    let cornerSm: CGFloat = 5
    
    func applyStyle(_ style: String, _ button: UIButton) {
        switch style {
        case bevelDfPr: setStyleBevelDfPr(style, button)
        case bevelDfSc: setStyleBevelDfSc(style, button)
        case bevelSmPr: setStyleBevelSmPr(style, button)
        case bevelSmSc: setStyleBevelSmSc(style, button)
        case dialogDfPr: setStyleBevelDfPr(style, button)
        case dialogDfSc: setStyleBevelDfSc(style, button)
        case circleDfPlus: setStyleCircleDfPlus(style, button)
        case quietDfSc: setStyleQuietDfSc(style, button)
        case sharpLgPr: setStyleSharpLgPr(style, button)
        case Styles.shared.view.navbarPr: setStyleNavbarPr(style, button)
        default:
            print("no button style \(style)")
        }
    }
    
    func applyStyle(_ style: String, _ button: UIBarButtonItem) {
        switch style {
        case Styles.shared.view.navbarPr: setStyleNavbarPr(style, button)
        default:
            print("no barbutton style \(style)")
        }
    }
    
    func applyStyle(_ style: String, _ button: UISwitch) {
        switch style {
        case swtch: setStyleSwtch(style, button)
        default:
            print("no switch style \(style)")
        }
    }
    
    private func setTextFont(_ style: String, _ button: UIButton, _ state: UIControl.State = .normal) {
        let fontStyle = Styles.shared.getFontStyle(style)
        button.titleLabel?.font = Styles.shared.getFont(style)
        button.setTitleColor(fontStyle.color.withAlphaComponent(fontStyle.a), for: state)
    }

    private func setStyleCommon(button: UIButton, upColor: UIColor, downColor: UIColor, height: CGFloat, cornerRadius: CGFloat, fontStyle: String) {
        button.backgroundColor = upColor
        button.setHighlightedBackgroundColor(downColor)
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        if cornerRadius > 0 {
            button.clipsToBounds = true
            button.layer.cornerRadius = cornerRadius
        }
        if !fontStyle.isEmpty {
            setTextFont(fontStyle, button)
        }
    }

    private func setStyleBevelDfPr(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.color.buttonPrUp,
                       downColor: Styles.shared.color.buttonPrDown,
                       height: sizeDf,
                       cornerRadius: cornerDf,
                       fontStyle: style)
    }

    private func setStyleBevelDfSc(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.color.buttonScUp,
                       downColor: Styles.shared.color.buttonScDown,
                       height: sizeDf,
                       cornerRadius: cornerDf,
                       fontStyle: style)
    }
    
    private func setStyleBevelSmPr(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.color.buttonPrUp,
                       downColor: Styles.shared.color.buttonPrDown,
                       height: sizeSm,
                       cornerRadius: cornerSm,
                       fontStyle: style)
    }

    private func setStyleBevelSmSc(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.color.buttonScUp,
                       downColor: Styles.shared.color.buttonScDown,
                       height: sizeSm,
                       cornerRadius: cornerSm,
                       fontStyle: style)
    }

    private func setStyleCircleDfPlus(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.color.buttonFlowUp,
                       downColor: Styles.shared.color.buttonFlowDown,
                       height: sizeDf,
                       cornerRadius: sizeDf / 2,
                       fontStyle: "")
        button.widthAnchor.constraint(equalToConstant: sizeDf).isActive = true
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: Assets.shared.buttonFlowPlus), for: .normal)
    }
    
    private func setStyleQuietDfSc(_ style: String, _ button: UIButton) {
        setTextFont(style, button)
        setTextFont("\(quietDfSc)Down", button, .highlighted)
    }
    
    private func setStyleNavbarPr(_ style: String, _ button: UIButton) {
        setTextFont(style, button)
    }

    private func setStyleSharpLgPr(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.color.buttonPrUp,
                       downColor: Styles.shared.color.buttonPrDown,
                       height: sizeLg,
                       cornerRadius: 0,
                       fontStyle: style)
        button.setDisabledBackgroundColor(Styles.shared.color.buttonPrDisabled)
    }

    private func setStyleNavbarPr(_ style: String, _ button: UIBarButtonItem) {
        let attributes = Styles.shared.getAttributes(style)
        button.setTitleTextAttributes(attributes, for: .normal)
        button.setTitleTextAttributes(attributes, for: .highlighted)
    }
    
    private func setStyleSwtch(_ style: String, _ switchButton: UISwitch) {
        switchButton.onTintColor = Styles.shared.color.switchBgOn
        switchButton.tintColor = Styles.shared.color.switchBgOff
        switchButton.thumbTintColor = Styles.shared.color.switchThumb
        switchButton.backgroundColor = Styles.shared.color.switchBgOff
        switchButton.layer.cornerRadius = switchButton.bounds.height / 2
    }
}

// MARK: - Label
final class LabelStyles {
    
    let r16ffffffC = "r16ffffffC"
    let r18main = "r18main"
    let r20main = "r20main"
    let b20mainC = "b20mainC"
    let b229796a9 = "b229796a9"
    let b22main = "b22main"
    
    func applyStyle(_ style: String, _ label: UILabel) {
        let fontStyle = Styles.shared.getFontStyle(style)
        label.font = Styles.shared.getFont(style)
        label.textColor = fontStyle.color.withAlphaComponent(fontStyle.a)
        label.textAlignment = fontStyle.ha
    }
}

// MARK: - Textfield
final class TextfieldStyles {
    
    let odPh = "odPh"
    let odPr = "odPr"
    let odPrT = "odPrT"
    let odPrM = "odPrM"
    let odPrB = "odPrB"
    let olPh = "olPh"
    let olPr = "olPr"
    let olPrT = "olPrT"
    let olPrM = "olPrM"
    let olPrB = "olPrB"
    
    let sizeDf: CGFloat = 50
    let sizeLg: CGFloat = 60
    let cornerDf: CGFloat = 10
    let paddingDf: CGFloat = 10
    
    func applyStyle(_ style: String, _ textfield: UITextField) {
        switch style {
        case olPr: setStyleOlPr(style, textfield)
        case olPrT: setStyleOlPrT(style, textfield)
        case olPrM: setStyleOlPrM(style, textfield)
        case olPrB: setStyleOlPrB(style, textfield)
        case odPr: setStyleOdPr(style, textfield)
        case odPrT: setStyleOdPrT(style, textfield)
        case odPrM: setStyleOdPrM(style, textfield)
        case odPrB: setStyleOdPrB(style, textfield)
        default:
            print("no tf style \(style)")
        }
    }
    
    func applyStyle(_ style: String, _ textview: UITextView) {
        switch style {
        case olPr: setStyleOlPr(style, textview)
        default:
            print("no tv style \(style)")
        }
    }
    
    private func setTextFont(_ style: String, textfield: UITextField) {
        let fontStyle = Styles.shared.getFontStyle(style)
        textfield.font = Styles.shared.getFont(style)
        textfield.textColor = fontStyle.color.withAlphaComponent(fontStyle.a)
        textfield.textAlignment = fontStyle.ha
    }
    
    private func setTextFont(_ style: String, textview: UITextView) {
        let fontStyle = Styles.shared.getFontStyle(style)
        textview.font = Styles.shared.getFont(style)
        textview.textColor = fontStyle.color.withAlphaComponent(fontStyle.a)
        textview.textAlignment = fontStyle.ha
    }
    
    private func setStyleCommon(_ textfield: UITextField, _ fontStyle: String, _ phStyle: String, _ cornerRadius: CGFloat = 0) {
        textfield.borderStyle = .none
        textfield.clipsToBounds = true
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 1
        if cornerRadius > 0 {
            textfield.layer.cornerRadius = cornerRadius
        }
        textfield.setHorizontalTextPadding(paddingDf)
        textfield.tintColor = Styles.shared.getFontColor(fontStyle)
        textfield.setPlaceholer(textfield.placeholder ?? "", with: phStyle)
        setTextFont(fontStyle, textfield: textfield)
    }
    
    private func setStyleOlCommon(_ style: String, _ textfield: UITextField, _ cornerRadius: CGFloat = 0) {
        setStyleCommon(textfield, olPr, olPh, cornerRadius)
        textfield.showTfOlUp()
    }
    
    private func setStyleOlPr(_ style: String, _ textfield: UITextField) {
        setStyleOlCommon(style, textfield, cornerDf)
    }
    
    private func setStyleOlPrT(_ style: String, _ textfield: UITextField) {
        setStyleOlCommon(style, textfield)
        textfield.setTopCornerRadius(value: cornerDf)
    }
    
    private func setStyleOlPrM(_ style: String, _ textfield: UITextField) {
        setStyleOlCommon(style, textfield)
    }
    
    private func setStyleOlPrB(_ style: String, _ textfield: UITextField) {
        setStyleOlCommon(style, textfield)
        textfield.setBottomCornerRadius(value: cornerDf)
    }
    
    private func setStyleOlPr(_ style: String, _ textview: UITextView) {
        //textview.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textview.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -2)
        textview.tintColor = Styles.shared.getFontColor(olPr)
        setTextFont(olPr, textview: textview)
    }
    
    private func setStyleOdCommon(_ style: String, _ textfield: UITextField, _ cornerRadius: CGFloat = 0) {
        setStyleCommon(textfield, odPr, odPh, cornerRadius)
        textfield.showTfOdUp()
    }
    
    private func setStyleOdPr(_ style: String, _ textfield: UITextField) {
        setStyleOdCommon(style, textfield, cornerDf)
    }
    
    private func setStyleOdPrT(_ style: String, _ textfield: UITextField) {
        setStyleOdCommon(style, textfield)
        textfield.setTopCornerRadius(value: cornerDf)
    }
    
    private func setStyleOdPrM(_ style: String, _ textfield: UITextField) {
        setStyleOdCommon(style, textfield)
    }
    
    private func setStyleOdPrB(_ style: String, _ textfield: UITextField) {
        setStyleOdCommon(style, textfield)
        textfield.setBottomCornerRadius(value: cornerDf)
    }
}

// MARK: - View
final class ViewStyles {
    
    let navbarPr = "navbarPr"
    let navbarPrC = "navbarPrC"

    let popup = "popup"
    
    let cornerDf: CGFloat = 10
    let cornerPopup: CGFloat = 15
    let sizeNavbar: CGFloat = 44
    
    private var _topInset = CGFloat.zero
    private var _bottomInset = CGFloat.zero
    
    var topInset: CGFloat {
        get {
            if _topInset > 0 {
                return _topInset
            }
            _topInset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? .zero
            return _topInset
        }
    }
    
    var bottomInset: CGFloat {
        get {
            if _bottomInset > 0 {
                return _bottomInset
            }
            _bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? .zero
            return _bottomInset
        }
    }
    
    var screenWidth: CGFloat {
        get { return UIScreen.main.bounds.width }
    }
    
    var screenHeight: CGFloat {
        get { return UIScreen.main.bounds.height }
    }
    
    func applyStyle(_ style: String, _ view: UIView) {
        switch style {
        case popup: setStylePopup(style, view)
        default:
            print("no view style \(style)")
        }
    }
    
    private func setStylePopup(_ style: String, _ view: UIView) {
        view.backgroundColor = Styles.shared.color.vc
        view.layer.cornerRadius = cornerPopup
        Styles.shared.addShadow(view, x: 0, y: 6, a: 0.2, blur: 10, cornerRadius: cornerPopup)
    }
}

