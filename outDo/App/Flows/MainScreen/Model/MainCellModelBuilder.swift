//
//  MainCellModelBuilder.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

import UIKit.UIColor

final class MainCellModelBuilder {
    
    private let cell: String
    private(set) var text: String?
    private(set) var title: String?
    private(set) var bgColor: UIColor?
    private(set) var stateColor: UIColor?
    
    init(_ cell: String) {
        self.cell = cell
    }
    
    func setBgColor(_ value: UIColor) -> Self {
        self.bgColor = value
        return self
    }
    
    func setStateColor(_ value: UIColor) -> Self {
        self.stateColor = value
        return self
    }
    
    func setText(_ value: String) -> Self {
        self.text = value
        return self
    }
    
    func setTitle(_ value: String) -> Self {
        self.title = value
        return self
    }
    
    func build() -> MainCellModel {
        return MainCellModel(
            cell: cell,
            text: text ?? "",
            title: title ?? "",
            bgColor: bgColor ?? .vc,
            stateColor: stateColor ?? .clear)
    }
}
