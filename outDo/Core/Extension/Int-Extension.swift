//
//  Int-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

extension Int {
    
    init(_ value: Any?, defaultValue: Int = 0) {
        self = Int(Double(value, defaultValue: Double(defaultValue)))
    }
}
