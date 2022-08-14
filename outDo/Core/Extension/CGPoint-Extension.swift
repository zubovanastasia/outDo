//
//  CGPoint-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

extension CGPoint {
    
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGPoint {
        return CGPoint(x: x.projectedOffset(decelerationRate: decelerationRate), y: y.projectedOffset(decelerationRate: decelerationRate))
    }
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
