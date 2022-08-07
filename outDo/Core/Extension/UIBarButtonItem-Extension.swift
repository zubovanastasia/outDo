//
//  UIBarButtonItem-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit

extension UIBarButtonItem {
    
    var style: String {
        get { return "" }
        set { Styles.shared.applyStyle(newValue, self) }
    }
}
