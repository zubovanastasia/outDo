//
//  UIColor-Extension+Theme.swift
//  outDo
//
//  Created by Антон Бондаренко on 26.08.2022.
//

import UIKit

extension UIColor {
    
    class var dialogDark: UIColor       { .black.withAlphaComponent(0.2) }
    class var toast: UIColor            { UIColor(rgb: 0x333333) }
    class var vc: UIColor               { .white }
    class var vcGray: UIColor           { UIColor(rgb: 0xafafaf) }
    
    class var fcMain: UIColor           { .black }
    class var fcSc: UIColor             { UIColor(rgb: 0x646464) }
    
    class var c323232: UIColor          { UIColor(rgb: 0x323232) }
    class var c514f65: UIColor          { UIColor(rgb: 0x514f65) }
    class var c646464: UIColor          { UIColor(rgb: 0x646464) }
    class var c969696: UIColor          { UIColor(rgb: 0x969696) }
    class var c9796a9: UIColor          { UIColor(rgb: 0x9796a9) }
    
    class var buttonPrUp: UIColor       { UIColor(rgb: 0x3d3c49) }
    class var buttonPrDown: UIColor     { buttonPrUp.modified(additionalBrightness: -0.05) }
    class var buttonPrDisabled: UIColor { buttonPrUp.modified(additionalBrightness: 0.15) }
    class var buttonScUp: UIColor       { UIColor(rgb: 0xfafafa) }
    class var buttonScDown: UIColor     { buttonScUp.modified(additionalBrightness: -0.05) }
    class var buttonFlowUp: UIColor     { UIColor(rgb: 0xffffff) }
    class var buttonFlowDown: UIColor   { buttonScUp.modified(additionalBrightness: -0.03) }
    class var switchBgOn: UIColor       { UIColor(rgb: 0x007aff) }
    class var switchBgOff: UIColor      { UIColor(rgb: 0xdcdcdc) }
    class var switchThumb: UIColor      { UIColor(rgb: 0xffffff) }
    class var sep: UIColor              { .black.withAlphaComponent(0.09) }
    
    class var tfOdBorderUp: UIColor     { .white }
    class var tfOdBorderFocused: UIColor{ UIColor(rgb: 0xaaaaaa) }
    class var tfOdBorderError: UIColor  { UIColor(rgb: 0xf9b290) }
    class var tfOdBgUp: UIColor         { .clear }
    class var tfOdBgFocused: UIColor    { .white.withAlphaComponent(0.05) }
    class var tfOdBgError: UIColor      { UIColor(rgb: 0xf9b290) }

    class var tfOlBorderUp: UIColor     { UIColor(rgb: 0xdddddd) }
    class var tfOlBorderFocused: UIColor{ UIColor(rgb: 0xdadada) }
    class var tfOlBorderError: UIColor  { UIColor(rgb: 0xf9b290) }
    class var tfOlBgUp: UIColor         { .clear }
    class var tfOlBgFocused: UIColor    { UIColor(rgb: 0xb3b34d, a: 0.05) }
    class var tfOlBgError: UIColor      { UIColor(rgb: 0xf9b290) }
    
    class var stateCreatedBg: UIColor     { .white }
    class var stateCreatedSolid: UIColor  { UIColor(rgb: 0x87cefa) }
    class var stateProcessedBg: UIColor   { UIColor(rgb: 0xffffe0) }
    class var stateProcessedSolid: UIColor{ UIColor(rgb: 0xf0e68c) }
    class var stateCompletedBg: UIColor   { UIColor(rgb: 0xf0fff0) }
    class var stateCompletedSolid: UIColor{ UIColor(rgb: 0x00fa9a) }
    class var stateCancelledBg: UIColor   { UIColor(rgb: 0xfff0f5) }
    class var stateCancelledSolid: UIColor{ UIColor(rgb: 0xff6347) }
    
    static private var mainStateColors: [TTaskState: UIColor] = [
        .created: stateCreatedSolid,
        .processed: stateProcessedSolid,
        .completed: stateCompletedSolid,
        .cancelled: stateCancelledSolid
    ]
    
    static private var mainBgColors: [TTaskState: UIColor] = [
        .created: stateCreatedBg,
        .processed: stateProcessedBg,
        .completed: stateCompletedBg,
        .cancelled: stateCancelledBg
    ]
    
    static func getMainStateColor(_ state: TTaskState) -> UIColor {
        mainStateColors[state] ?? .clear
    }
    
    static func getMainBgColor(_ state: TTaskState) -> UIColor {
        mainBgColors[state] ?? .clear
    }
}
