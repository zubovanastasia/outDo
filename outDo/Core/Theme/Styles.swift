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

class Styles {
    
    static let shared = Styles()
    
    let button = ButtonStyles()
    let label = LabelStyles()
    let tfs = TextfieldStyles()
    let view = ViewStyles()
    
    let c = Colors()
    let fs = FontSizes()
    
    private let fontR = "SourceSansPro-Regular"
    private let fontB = "SourceSansPro-SemiBold"
    
    private var tf = [String:MFont]()
    private var tfFonts = [String:UIFont]()
    
    init() {
        tf[button.bevelDfPr] = MFont(fs.fs24, fontB, c.cffffff, NSTextAlignment.left)
        tf[button.bevelDfSc] = MFont(fs.fs24, fontB, c.c646464, NSTextAlignment.left)
        tf[button.bevelSmPr] = MFont(fs.fs20, fontB, c.cffffff, NSTextAlignment.left)
        tf[button.bevelSmSc] = MFont(fs.fs20, fontB, c.c646464, NSTextAlignment.left)
        tf[button.dialogDfPr] = MFont(fs.fs20, fontB, c.cffffff, NSTextAlignment.left)
        tf[button.dialogDfSc] = MFont(fs.fs20, fontB, c.c646464, NSTextAlignment.left)
        tf[button.sharpLgPr] = MFont(fs.fs28, fontB, c.cffffff, NSTextAlignment.left)
        tf[button.sharpQuietDfApvd] = MFont(fs.fs20, fontB, c.c000000, NSTextAlignment.right, true)
        tf[button.sharpQuietDfApvl] = MFont(fs.fs20, fontB, c.c348cfc, NSTextAlignment.right, true)
        tf[button.sharpQuietHgApvd] = MFont(fs.fs44, fontB, c.c000000, NSTextAlignment.left, true)
        tf[button.sharpQuietHgApvl] = MFont(fs.fs44, fontB, c.c348cfc, NSTextAlignment.left, true)
        tf[button.sharpQuietDfE2Ac] = MFont(fs.fs22, fontB, c.c514f65, NSTextAlignment.left)
        tf[button.sharpQuietDfE2Pr] = MFont(fs.fs22, fontB, c.c514f65, NSTextAlignment.left)
        tf[button.sharpQuietDfE2Tr] = MFont(fs.fs22, fontB, c.c9796a9, NSTextAlignment.left)
        tf[button.sharpQuietDfScheduleOff] = MFont(fs.fs22, fontR, c.c9796a9, NSTextAlignment.left)
        tf[button.sharpQuietDfScheduleOn] = MFont(fs.fs22, fontB, c.c514f65, NSTextAlignment.left)
        
        tf[label.r14mainA05] = MFont(fs.fs14, fontR, c.c000000, NSTextAlignment.left, false, 0.5)
        tf[label.b16323232C] = MFont(fs.fs16, fontR, c.c323232, NSTextAlignment.center)
        tf[label.r16ffffffC] = MFont(fs.fs16, fontR, c.cffffff, NSTextAlignment.center)
        tf[label.r18mainA06] = MFont(fs.fs18, fontR, c.c000000, NSTextAlignment.left, false, 0.6)
        tf[label.b18737090] = MFont(fs.fs18, fontB, c.c737090, NSTextAlignment.left)
        tf[label.r18808080] = MFont(fs.fs18, fontR, c.c808080, NSTextAlignment.left)
        tf[label.r18999999] = MFont(fs.fs18, fontR, c.c999999, NSTextAlignment.left)
        tf[label.r18999999R] = MFont(fs.fs18, fontR, c.c999999, NSTextAlignment.right)
        tf[label.b18ffffff] = MFont(fs.fs18, fontB, c.cffffff, NSTextAlignment.left)
        tf[label.r20main] = MFont(fs.fs20, fontR, c.c000000, NSTextAlignment.left)
        tf[label.r20mainC] = MFont(fs.fs20, fontR, c.c000000, NSTextAlignment.center)
        tf[label.r20514f65] = MFont(fs.fs20, fontR, c.c514f65, NSTextAlignment.left)
        tf[label.b20514f65] = MFont(fs.fs20, fontR, c.c514f65, NSTextAlignment.left)
        tf[label.r20514f65R] = MFont(fs.fs20, fontR, c.c514f65, NSTextAlignment.right)
        tf[label.r20737090] = MFont(fs.fs20, fontR, c.c737090, NSTextAlignment.left)
        tf[label.r20737090R] = MFont(fs.fs20, fontR, c.c737090, NSTextAlignment.right)
        tf[label.r209796a9] = MFont(fs.fs20, fontR, c.c9796a9, NSTextAlignment.left)
        tf[label.r209796a9R] = MFont(fs.fs20, fontR, c.c9796a9, NSTextAlignment.right)
        tf[label.b20ffffff] = MFont(fs.fs20, fontB, c.cffffff, NSTextAlignment.left)
        tf[label.b20ffffffR] = MFont(fs.fs20, fontB, c.cffffff, NSTextAlignment.right)
        tf[label.b22main] = MFont(fs.fs22, fontB, c.c000000, NSTextAlignment.left)
        tf[label.r22main] = MFont(fs.fs22, fontR, c.c000000, NSTextAlignment.left)
        tf[label.b22mainA06] = MFont(fs.fs22, fontB, c.c000000, NSTextAlignment.left, false, 0.6)
        tf[label.b22mainC] = MFont(fs.fs22, fontB, c.c000000, NSTextAlignment.center)
        tf[label.r22mainC] = MFont(fs.fs22, fontR, c.c000000, NSTextAlignment.center)
        tf[label.r22mainCA05] = MFont(fs.fs22, fontR, c.c000000, NSTextAlignment.center, false, 0.5)
        tf[label.b22348cfc] = MFont(fs.fs22, fontB, c.c348cfc, NSTextAlignment.left)
        tf[label.r22514f65] = MFont(fs.fs22, fontR, c.c514f65, NSTextAlignment.left)
        tf[label.b22514f65] = MFont(fs.fs22, fontB, c.c514f65, NSTextAlignment.left)
        tf[label.r22514f65R] = MFont(fs.fs22, fontR, c.c514f65, NSTextAlignment.right)
        tf[label.r22323232] = MFont(fs.fs22, fontR, c.c323232, NSTextAlignment.left)
        tf[label.r22646464R] = MFont(fs.fs22, fontR, c.c646464, NSTextAlignment.right)
        tf[label.r22737090] = MFont(fs.fs22, fontR, c.c737090, NSTextAlignment.left)
        tf[label.b22737090] = MFont(fs.fs22, fontB, c.c737090, NSTextAlignment.left)
        tf[label.r22737090C] = MFont(fs.fs22, fontR, c.c737090, NSTextAlignment.center)
        tf[label.b22737090R] = MFont(fs.fs22, fontB, c.c737090, NSTextAlignment.right)
        tf[label.r22737090R] = MFont(fs.fs22, fontR, c.c737090, NSTextAlignment.right)
        tf[label.r22969696] = MFont(fs.fs22, fontR, c.c969696, NSTextAlignment.left)
        tf[label.b229796a9] = MFont(fs.fs22, fontB, c.c9796a9, NSTextAlignment.left)
        tf[label.b22ffffff] = MFont(fs.fs22, fontB, c.cffffff, NSTextAlignment.left)
        tf[label.r22ffffff] = MFont(fs.fs22, fontR, c.cffffff, NSTextAlignment.left)
        tf[label.r22ffffffC] = MFont(fs.fs22, fontR, c.cffffff, NSTextAlignment.center)
        tf[label.b24514f65] = MFont(fs.fs24, fontB, c.c514f65, NSTextAlignment.left)
        tf[label.b26main] = MFont(fs.fs26, fontB, c.c000000, NSTextAlignment.left)
        tf[label.b28main] = MFont(fs.fs28, fontB, c.c000000, NSTextAlignment.left)
        tf[label.b28mainC] = MFont(fs.fs28, fontB, c.c000000, NSTextAlignment.center)
        tf[label.b28323232C] = MFont(fs.fs28, fontB, c.c323232, NSTextAlignment.center)
        tf[label.b28737090C] = MFont(fs.fs28, fontB, c.c737090, NSTextAlignment.center)
        tf[label.b40mainC] = MFont(fs.fs40, fontB,  c.c000000, NSTextAlignment.center)
        tf[label.b40mainCAdj] = MFont(fs.fs40, fontB,  c.c000000, NSTextAlignment.center, true)
        tf[label.b44mainC] = MFont(fs.fs44, fontB, c.c000000, NSTextAlignment.center)

        tf[tfs.odPh] = MFont(fs.fs24, fontR, c.cffffff, NSTextAlignment.left, false, 0.4)
        tf[tfs.odPr] = MFont(fs.fs24, fontB, c.cffffff, NSTextAlignment.left)
        tf[tfs.olPh] = MFont(fs.fs24, fontR, c.c000000, NSTextAlignment.left, false, 0.4)
        tf[tfs.olPr] = MFont(fs.fs24, fontB, c.c000000, NSTextAlignment.left)

        tf[view.navbarAc] = MFont(fs.fs20, fontB, c.c000000, NSTextAlignment.left)
        tf[view.navbarPr] = MFont(fs.fs20, fontB, c.c000000, NSTextAlignment.left, false, 0.55)
        tf[view.navbarPrC] = MFont(fs.fs20, fontB, c.c000000, NSTextAlignment.center, false, 0.55)
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

//    func addShadow(_ view: UIImageView, y: Double, a: Double, blur: Double = 10.0) {
//        addShadow(layer: view.layer, path: UIBezierPath(rect: view.bounds), offset: CGSize(width: 0, height: y), color: .black, opacity: Float(a), radius: CGFloat(blur))
//    }

    func addShadow(_ view: UIView, x: Double, y: Double, a: Double, blur: Double = 10.0, cornerRadius: CGFloat = 0) {
        if cornerRadius == 0 {
            addShadow(layer: view.layer, path: UIBezierPath(rect: view.bounds), offset: CGSize(width: x, height: y), color: .black, opacity: Float(a), radius: CGFloat(blur))
        }
        else {
            addShadow(layer: view.layer, path: UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius), offset: CGSize(width: x, height: y), color: .black, opacity: Float(a), radius: CGFloat(blur))
        }
    }
//
//    func addShadow(_ tableView:UITableView, y:Double, a:Double, blur:Double = 10.0) {
//        addShadow(layer: tableView.layer, path: UIBezierPath(rect: tableView.bounds), offset: CGSize(width: 0, height: y), color: .black, opacity: Float(a), radius: CGFloat(blur))
//    }
//
//    func removeShadow(_ tableView:UITableView) {
//        tableView.layer.shadowOffset = CGSize.zero
//        tableView.layer.shadowColor = UIColor.clear.cgColor
//        tableView.layer.shadowOpacity = 0.0
//    }
}

// MARK: - Colors
class Colors {
    
    let dialogDark = UIColor(rgb: 0x000000, a: 0.3)
    let mapRoute = UIColor(rgb: 0x3498db)
    let notification  = UIColor(rgb: 0x31303b)
    let toast = UIColor(rgb: 0x333333)
    let vc = UIColor(rgb: 0xffffff)
    let vcGray = UIColor(rgb: 0xf1f1f1)

    let fcMain = UIColor(rgb: 0x000000)
    
    let c000000 = UIColor(rgb: 0x000000)
    let c323232 = UIColor(rgb: 0x323232)
    let c348cfc = UIColor(rgb: 0x348cfc)
    let c514f65 = UIColor(rgb: 0x514f65)
    let c646464 = UIColor(rgb: 0x646464)
    let c737090 = UIColor(rgb: 0x737090)
    let c808080 = UIColor(rgb: 0x808080)
    let c969696 = UIColor(rgb: 0x969696)
    let c9796a9 = UIColor(rgb: 0x9796a9)
    let c999999 = UIColor(rgb: 0x999999)
    let cf7f7f3 = UIColor(rgb: 0xf7f7f3)
    let cffffff = UIColor(rgb: 0xffffff)

    let mainBgDefault = UIColor(rgb: 0xf7f7f3)
    let mainBgBidding = UIColor(rgb: 0xafe7ff)
    let mainBgGray = UIColor(rgb: 0xfafafa)
    let mainBgOnLocation = UIColor(rgb: 0xfcf9d3)
    let mainStateArriving = UIColor(rgb: 0xffb65f)
    let mainStateCancelled = UIColor(rgb: 0xfcf9d3)
    let mainStateOnLocation = UIColor(rgb: 0xffeb3b)
    let mainStateSearching = UIColor(rgb: 0x5fcfff)
    let tagE3 = UIColor(rgb: 0xffeb3b)
    let tagEr = UIColor(rgb: 0xfc553c)

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
    
    let tfOlBorderUp = UIColor(rgb: 0xdddddd)
    let tfOlBorderFocused = UIColor(rgb: 0xdadada)
    let tfOlBorderError = UIColor(rgb: 0xf9b290)
    let tfOlBgUp = UIColor(rgb: 0xffffff, a: 0)
    let tfOlBgFocused = UIColor(rgb: 0xb3b34d, a: 0.05)
    let tfOlBgError = UIColor(rgb: 0xf9b290)

    let tfOdBorderUp = UIColor(rgb: 0x3d5976)
    let tfOdBorderFocused = UIColor(rgb: 0xaaaaaa)
    let tfOdBorderError = UIColor(rgb: 0xf9b290)
    let tfOdBgUp = UIColor(rgb: 0xffffff, a: 0)
    let tfOdBgFocused = UIColor(rgb: 0xffffff, a: 0.05)
    let tfOdBgError = UIColor(rgb: 0xf9b290)
    
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
class ButtonStyles {
    
    let bevelDfPr = "bevelDfPr"
    let bevelDfSc = "bevelDfSc"
    let bevelSmPr = "bevelSmPr"
    let bevelSmSc = "bevelSmSc"
    let callbarCall = "callbarCall"
    let callbarChat = "callbarChat"
    let callbarChatAnimated = "callbarChatAnimated"
    let callbarMap  = "callbarMap"
    let circleDfLocation = "circleDfLocation"
    let circleDfPlus = "circleDfPlus"
    let dialogDfPr = "dialogDfPr"
    let dialogDfSc = "dialogDfSc"
    let sharpLgPr = "sharpLgPr"
    let sharpQuietDfApvd = "sharpQuietDfApvd"
    let sharpQuietDfApvl = "sharpQuietDfApvl"
    let sharpQuietDfE2Ac = "sharpQuietDfE2Ac"
    let sharpQuietDfE2Pr = "sharpQuietDfE2Pr"
    let sharpQuietDfE2Tr = "sharpQuietDfE2Tr"
    let sharpQuietHgApvd = "sharpQuietHgApvd"
    let sharpQuietHgApvl = "sharpQuietHgApvl"
    let sharpQuietDfScheduleOff = "sharpQuietDfScheduleOff"
    let sharpQuietDfScheduleOn = "sharpQuietDfScheduleOn"
    let swtch = "swtch"
    
    let quietSend = "quietSend"
    
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
        case callbarCall: setStyleCallbarCall(style, button)
        case callbarChat: setStyleCallbarChat(style, button)
        case callbarChatAnimated: setStyleCallbarChatAnimated(style, button)
        case callbarMap: setStyleCallbarMap(style, button)
        case circleDfLocation: setStyleCircleDfLocation(style, button)
        case circleDfPlus: setStyleCircleDfPlus(style, button)
        case dialogDfPr: setStyleDialogDfPr(style, button)
        case dialogDfSc: setStyleDialogDfSc(style, button)
        case sharpLgPr: setStyleSharpLgPr(style, button)
        case sharpQuietDfApvd: setStyleSharpQuietDfApvd(style, button)
        case sharpQuietDfApvl: setStyleSharpQuietDfApvl(style, button)
        case sharpQuietDfE2Ac: setStyleSharpQuietDfE2Ac(style, button)
        case sharpQuietDfE2Pr: setStyleSharpQuietDfE2Pr(style, button)
        case sharpQuietDfE2Tr: setStyleSharpQuietDfE2Tr(style, button)
        case sharpQuietHgApvd: setStyleSharpQuietHgApvd(style, button)
        case sharpQuietHgApvl: setStyleSharpQuietHgApvl(style, button)
        case sharpQuietDfScheduleOff: setStyleSharpQuietDfScheduleOff(style, button)
        case sharpQuietDfScheduleOn: setStyleSharpQuietDfScheduleOn(style, button)
        case quietSend: setStyleQuietSend(style, button)
        case Styles.shared.view.navbarAc: setStyleNavbarAc(style, button)
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
    
    func getAppbarMapButton() -> UIButton {
        let button = UIButton(type: .custom)
        if let image = UIImage(named: Assets.shared.appbarMap)?.withTintColor(Styles.shared.getFontColor(Styles.shared.view.navbarPr)) {
            button.setImage(image, for: .normal)
        }
        if let image = UIImage(named: Assets.shared.appbarMap)?.withTintColor(Styles.shared.getFontColor(Styles.shared.view.navbarPr).modified(additionalBrightness: 0.1)) {
            button.setImage(image, for: .highlighted)
        }
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        return button
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
                       upColor: Styles.shared.c.buttonPrUp,
                       downColor: Styles.shared.c.buttonPrDown,
                       height: sizeDf,
                       cornerRadius: cornerDf,
                       fontStyle: style)
    }

    private func setStyleBevelDfSc(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.c.buttonScUp,
                       downColor: Styles.shared.c.buttonScDown,
                       height: sizeDf,
                       cornerRadius: cornerDf,
                       fontStyle: style)
    }
    
    private func setStyleBevelSmPr(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.c.buttonPrUp,
                       downColor: Styles.shared.c.buttonPrDown,
                       height: sizeSm,
                       cornerRadius: cornerSm,
                       fontStyle: style)
    }

    private func setStyleBevelSmSc(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.c.buttonScUp,
                       downColor: Styles.shared.c.buttonScDown,
                       height: sizeSm,
                       cornerRadius: cornerSm,
                       fontStyle: style)
    }

    private func setStyleCallbarCall(_ style: String, _ button: UIButton) {
        button.setImage(UIImage(named: Assets.shared.callbarCall), for: .normal)
    }
    
    private func setStyleCallbarChat(_ style: String, _ button: UIButton) {
        button.setImage(UIImage(named:Assets.shared.callbarChat), for: .normal)
    }
    
    private func setStyleCallbarChatAnimated(_ style: String, _ button: UIButton) {
        button.setImage(nil, for: .highlighted)
        let image = UIImage.animatedImage(with: Assets.shared.orderChatAnimationImages(), duration: 0.7)
        button.setImage(image, for: .normal)
    }

    private func setStyleCallbarMap(_ style: String, _ button: UIButton) {
        button.setImage(UIImage(named: Assets.shared.callbarMap), for: .normal)
    }

    private func setStyleCircleDfLocation(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.c.buttonFlowUp,
                       downColor: Styles.shared.c.buttonFlowDown,
                       height: sizeDf,
                       cornerRadius: sizeDf / 2,
                       fontStyle: "")
        button.widthAnchor.constraint(equalToConstant: sizeDf).isActive = true
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: Assets.shared.iconLocation), for: .normal)
    }
    
    private func setStyleCircleDfPlus(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.c.buttonFlowUp,
                       downColor: Styles.shared.c.buttonFlowDown,
                       height: sizeDf,
                       cornerRadius: sizeDf / 2,
                       fontStyle: "")
        button.widthAnchor.constraint(equalToConstant: sizeDf).isActive = true
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: Assets.shared.buttonFlowPlus), for: .normal)
    }
    
    private func setStyleDialogDfPr(_ style: String, _ button: UIButton) {
        setStyleBevelDfPr(style, button)
    }
    
    private func setStyleDialogDfSc(_ style: String, _ button: UIButton) {
        setStyleBevelDfSc(style, button)
    }
    
    private func setStyleNavbarPr(_ style: String, _ button: UIButton) {
        setTextFont(style, button)
    }

    private func setStyleNavbarAc(_ style: String, _ button: UIButton) {
        setTextFont(style, button)
    }

    private func setStyleSharpQuietCommon(_ style: String, _ button: UIButton) {
        setTextFont(style, button)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.8
    }
    
    private func setStyleSharpQuietDfApvd(_ style: String, _ button: UIButton) {
        setStyleSharpQuietCommon(style, button)
        let fontStyle = Styles.shared.getFontStyle(style)
        button.setTitleColor(fontStyle.color.withAlphaComponent(fontStyle.a * 0.5), for: .highlighted)
    }
    
    private func setStyleSharpQuietDfApvl(_ style: String, _ button: UIButton) {
        setStyleSharpQuietCommon(style, button)
        let fontStyle = Styles.shared.getFontStyle(style)
        button.setTitleColor(fontStyle.color.withAlphaComponent(fontStyle.a * 0.5), for: .highlighted)
    }

    private func setStyleSharpQuietDfE2Ac(_ style: String, _ button: UIButton) {
        setTextFont(style, button)
        let fontStyle = Styles.shared.getFontStyle(style)
        button.setTitleColor(fontStyle.color.withAlphaComponent(fontStyle.a * 0.5), for: .highlighted)
    }
    
    private func setStyleSharpQuietDfE2Pr(_ style: String, _ button: UIButton) {
        setTextFont(style, button)
        let fontStyle = Styles.shared.getFontStyle(style)
        button.setTitleColor(fontStyle.color.withAlphaComponent(fontStyle.a * 0.5), for: .highlighted)
    }
    
    private func setStyleSharpQuietDfE2Tr(_ style: String, _ button: UIButton) {
        setTextFont(style, button)
        let fontStyle = Styles.shared.getFontStyle(style)
        button.setTitleColor(fontStyle.color.withAlphaComponent(fontStyle.a * 0.5), for: .highlighted)
    }
    
    private func setStyleSharpQuietDfScheduleOff(_ style: String, _ button: UIButton) {
        button.setImage(UIImage(named: Assets.shared.iconScheduleOff), for: .normal)
        button.setImage(UIImage(named: Assets.shared.iconScheduleOff), for: .highlighted)
        setTextFont(style, button, .normal)
        let fontStyle = Styles.shared.getFontStyle(style)
        button.setTitleColor(fontStyle.color.withAlphaComponent(fontStyle.a * 0.5), for: .highlighted)
    }

    private func setStyleSharpQuietDfScheduleOn(_ style: String, _ button: UIButton) {
        button.setImage(UIImage(named: Assets.shared.iconScheduleOn), for: .normal)
        button.setImage(UIImage(named: Assets.shared.iconScheduleOn), for: .highlighted)
        setTextFont(style, button)
        let fontStyle = Styles.shared.getFontStyle(style)
        button.setTitleColor(fontStyle.color.withAlphaComponent(fontStyle.a * 0.5), for: .highlighted)
    }

    private func setStyleSharpLgPr(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.c.buttonPrUp,
                       downColor: Styles.shared.c.buttonPrDown,
                       height: sizeLg,
                       cornerRadius: 0,
                       fontStyle: style)
        button.setDisabledBackgroundColor(Styles.shared.c.buttonPrDisabled)
    }

    private func setStyleSharpQuietHgApvd(_ style: String, _ button: UIButton) {
        setStyleSharpQuietCommon(style, button)
    }

    private func setStyleSharpQuietHgApvl(_ style: String, _ button: UIButton) {
        setStyleSharpQuietCommon(style, button)
    }

    private func setStyleQuietSend(_ style: String, _ button: UIButton) {
        setStyleCommon(button: button,
                       upColor: Styles.shared.c.cffffff,
                       downColor: Styles.shared.c.cffffff,
                       height: sizeLg,
                       cornerRadius: 0,
                       fontStyle: "")
        button.widthAnchor.constraint(equalToConstant: sizeLg).isActive = true
        button.setImage(UIImage(named: Assets.shared.iconChatSend), for: .normal)
    }
    
    private func setStyleNavbarPr(_ style: String, _ button: UIBarButtonItem) {
        let attributes = Styles.shared.getAttributes(style)
        button.setTitleTextAttributes(attributes, for: .normal)
        button.setTitleTextAttributes(attributes, for: .highlighted)
    }
    
    private func setStyleSwtch(_ style: String, _ switchButton: UISwitch) {
        switchButton.onTintColor = Styles.shared.c.switchBgOn
        switchButton.tintColor = Styles.shared.c.switchBgOff
        switchButton.thumbTintColor = Styles.shared.c.switchThumb
        switchButton.backgroundColor = Styles.shared.c.switchBgOff
        switchButton.layer.cornerRadius = switchButton.bounds.height / 2
    }
}

// MARK: - Label
class LabelStyles {
    
    let r14mainA05 = "r14mainA05"
    let b16323232C = "b16323232C"
    let r16ffffffC = "r16ffffffC"
    let r18mainA06 = "r18mainA06"
    let b18737090 = "b18737090"
    let b18ffffff = "b18ffffff"
    let r18808080 = "r18808080"
    let r18999999 = "r18999999"
    let r18999999R = "r18999999R"
    let r20main = "r20main"
    let r20mainC = "r20mainC"
    let r20514f65 = "r20514f65"
    let b20514f65 = "b20514f65"
    let r20514f65R = "r20514f65R"
    let r20737090 = "r20737090"
    let r209796a9 = "r209796a9"
    let r209796a9R = "r209796a9R"
    let r20737090R = "r20737090R"
    let b20ffffff = "b20ffffff"
    let b20ffffffR = "b20ffffffR"
    let b22main = "b22main"
    let r22main = "r22main"
    let b22mainA06 = "b22mainA06"
    let b22mainC = "b22mainC"
    let r22mainC = "r22mainC"
    let r22mainCA05 = "r22mainCA05"
    let b22348cfc = "b22348cfc"
    let r22514f65 = "r22514f65"
    let b22514f65 = "b22514f65"
    let r22514f65R = "r22514f65R"
    let r22323232 = "r22323232"
    let r22646464R = "r22646464R"
    let r22737090 = "r22737090"
    let b22737090 = "b22737090"
    let b22737090R = "b22737090R"
    let r22737090C = "r22737090C"
    let r22737090R = "r22737090R"
    let r22969696  = "r22969696"
    let b229796a9 = "b229796a9"
    let r22ffffff = "r22ffffff"
    let b22ffffff = "b22ffffff"
    let r22ffffffC = "r22ffffffC"
    let b24514f65 = "b24514f65"
    let b26main = "b26main"
    let b28main = "b28main"
    let b28mainC = "b28mainC"
    let b28323232C = "b28323232C"
    let b28737090C = "b28737090C"
    let b40mainC = "b40mainC"
    let b40mainCAdj = "b40mainCAdj"
    let b44mainC = "b44mainC"
    
    func applyStyle(_ style: String, _ label: UILabel) {
        let fontStyle = Styles.shared.getFontStyle(style)
        label.font = Styles.shared.getFont(style)
        label.textColor = fontStyle.color.withAlphaComponent(fontStyle.a)
        label.textAlignment = fontStyle.ha
    }
}

// MARK: - Textfield
class TextfieldStyles {
    
    let odPh = "odPh"
    let odPr = "odPr"
    let odPrT = "odPrT"
    let odPrB = "odPrB"
    let olChat = "olChat"
    let olPh = "olPh"
    let olPr = "olPr"
    let olPrT = "olPrT"
    let olPrM = "olPrM"
    let olPrB = "olPrB"
    let olPrTL = "olPrTL"
    let olPrBL = "olPrBL"
    let olPrTR = "olPrTR"
    let olPrBR = "olPrBR"

    let sizeDf: CGFloat = 50
    let sizeLg: CGFloat = 60
    let cornerDf: CGFloat = 10
    let paddingDf: CGFloat = 10
    
    func applyStyle(_ style: String, _ textfield: UITextField) {
        switch style {
        case odPr: setStyleOdPr(style, textfield)
        case odPrT: setStyleOdPrT(style, textfield)
        case odPrB: setStyleOdPrB(style, textfield)
        case olChat: setStyleOlChat(style, textfield)
        case olPr: setStyleOlPr(style, textfield)
        case olPrT: setStyleOlPrT(style, textfield)
        case olPrM: setStyleOlPrM(style, textfield)
        case olPrB: setStyleOlPrB(style, textfield)
        case olPrTL: setStyleOlPrTL(style, textfield)
        case olPrBL: setStyleOlPrBL(style, textfield)
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
    
    private func setStyleOdCommon(_ style: String, _ textfield: UITextField, _ cornerRadius: CGFloat = 0) {
        setStyleCommon(textfield, odPr, odPh, cornerRadius)
        textfield.showTfOdUp()
    }
    
    private func setStyleOlCommon(_ style: String, _ textfield: UITextField, _ cornerRadius: CGFloat = 0) {
        setStyleCommon(textfield, olPr, olPh, cornerRadius)
        textfield.showTfOlUp()
    }
    
    private func setStyleOdPr(_ style: String, _ textfield: UITextField) {
        setStyleOdCommon(style, textfield, cornerDf)
    }
    
    private func setStyleOdPrT(_ style: String, _ textfield: UITextField) {
        setStyleOdCommon(style, textfield)
        textfield.setTopCornerRadius(value: cornerDf)
    }
    
    private func setStyleOdPrB(_ style: String, _ textfield: UITextField) {
        setStyleOdPr(style, textfield)
        textfield.setBottomCornerRadius(value: cornerDf)
    }
    
    private func setStyleOlChat(_ style: String, _ textfield: UITextField) {
        textfield.borderStyle = .none
        textfield.setLeftPadding(paddingDf)
        setTextFont(olPr, textfield: textfield)
        textfield.tintColor = Styles.shared.getFontColor(olPr)
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
    
    private func setStyleOlPrTL(_ style: String, _ textfield: UITextField) {
        setStyleOlCommon(style, textfield)
        textfield.setLeftTopCornerRadius(value: cornerDf)
    }
    
    private func setStyleOlPrBL(_ style: String, _ textfield: UITextField) {
        setStyleOlCommon(style, textfield)
        textfield.setLeftBottomCornerRadius(value: cornerDf)
    }
    
    private func setStyleOlPr(_ style: String, _ textview: UITextView) {
        //textview.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textview.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -2)
        textview.tintColor = Styles.shared.getFontColor(olPr)
        setTextFont(olPr, textview: textview)
    }
}

// MARK: - View
class ViewStyles {
    
    let navbarAc = "navbarAc"
    let navbarPr = "navbarPr"
    let navbarPrC = "navbarPrC"

    let notification = "notification"
    let popup = "popup"
    let popupT = "popupT"
    
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
        case notification:  setStyleNotification(style, view)
        case popup: setStylePopup(style, view)
        case popupT: setStylePopupT(style, view)
        case Styles.shared.tfs.olPr: setStyleTfOlPr(style, view)
        case Styles.shared.tfs.olPrTR: setStyleOlPrTR(style, view)
        case Styles.shared.tfs.olPrBR: setStyleOlPrBR(style, view)
        default:
            print("no view style \(style)")
        }
    }
    
    private func setStyleNotification(_ style:String, _ view:UIView) {
        view.backgroundColor = Styles.shared.c.notification
        view.layer.cornerRadius = cornerPopup
        Styles.shared.addShadow(view, x: 0, y: 6, a: 0.2, blur: 10, cornerRadius: cornerPopup)
    }
    
    private func setStylePopup(_ style: String, _ view: UIView) {
        view.backgroundColor = Styles.shared.c.vc
        view.layer.cornerRadius = cornerPopup
        Styles.shared.addShadow(view, x: 0, y: 6, a: 0.2, blur: 10, cornerRadius: cornerPopup)
    }
    
    private func setStylePopupT(_ style: String, _ view: UIView) {
        view.backgroundColor = Styles.shared.c.vc
        view.setTopCornerRadius(value: cornerPopup)
        Styles.shared.addShadow(view, x: 0, y: 6, a: 0.2, blur: 10, cornerRadius: cornerPopup)
    }
    
    private func setStyleTfOlPr(_ style:String, _ view: UIView) {
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = Styles.shared.tfs.cornerDf
        view.showTfOlUp()
    }
    
    private func setStyleOlPrTR(_ style: String, _ view: UIView) {
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.showTfOlUp()
        view.setRightTopCornerRadius(value: Styles.shared.tfs.cornerDf)
    }

    private func setStyleOlPrBR(_ style: String, _ view: UIView) {
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.showTfOlUp()
        view.setRightBottomCornerRadius(value: Styles.shared.tfs.cornerDf)
    }
}

