//
//  CGFloat-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

extension CGFloat {
    
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        // from wwdc
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1000
        return self * multiplier
    }
}
