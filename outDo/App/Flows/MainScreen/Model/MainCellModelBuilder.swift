//
//  MainCellModelBuilder.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

final class MainCellModelBuilder {
    
    private let cell: String
    private(set) var text: String?
    private(set) var title: String?
    
    init(_ cell: String) {
        self.cell = cell
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
            title: title ?? "")
    }
}
