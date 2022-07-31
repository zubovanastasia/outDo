//
//  UIApplication-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
}
