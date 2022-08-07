//
//  UICollectionViewCell-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        get { return String(describing: self)}
    }
    
    static var nib: UINib {
        get { return UINib(nibName: identifier, bundle: nil) }
    }
}
