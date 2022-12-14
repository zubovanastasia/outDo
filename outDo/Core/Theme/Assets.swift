//
//  Assets.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation
import UIKit

class Assets {
    
    static let shared = Assets()
    
    let appbarBack = "appbar_back"
    let appbarBack2 = "appbar_back2"
    let appbarMenu = "appbar_menu"
    
    let buttonFlowPlus = "button_flow_plus"
    
    private func getImageWithInsets(_ name: String, _ insets: UIEdgeInsets) -> UIImage {
        var image = UIImage(named: name)
        image = image?.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        return image!
    }
}
