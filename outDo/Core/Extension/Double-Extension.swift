//
//  Double-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

// MARK: - Formatter
extension Double {
    
    var fixed1:  Double {
        get { return Double(String(format: "%.1f", self))! }
    }
    
    var fixed6:  Double {
        get { return Double(String(format: "%.6f", self))! }
    }
}

// MARK: - Date Components
extension Double {
    
    var days: Int {
        get { return Int(self / 86400) }
    }
    
    var hours: Int {
        get { return Int(self.truncatingRemainder(dividingBy: 86400) / 3600) }
    }
    
    var minutes: Int {
        get { return Int(self.truncatingRemainder(dividingBy: 3600) / 60) }
    }
    
    var seconds: Int {
        get { return Int(self.truncatingRemainder(dividingBy: 60)) }
    }
}

// MARK: - Convert
extension Double {
    
    init(_ value: Any?, defaultValue: Double = 0) {
        if let val = value as? NSNumber {
            self = val.doubleValue
            return
        }
        else if let val = value as? String {
            if val.isEmpty {
                self = 0
                return
            }
            if let val = Double(val) {
                self = val
                return
            }
        }
        self = defaultValue
    }
    
    var date: Date {
        get { return Date(timeIntervalSince1970: self / 1000) }
    }
}

