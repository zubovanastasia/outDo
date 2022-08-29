//
//  NavigationDrawerCellModelBuilder.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

final class NavigationDrawerCellModelBuilder {
    
    private(set) var action: TAction?
    private(set) var icon: String?
    private(set) var title: String?
    private(set) var value: String?
    
    func setAction(_ value: TAction) -> Self {
        self.action = value
        return self
    }
    
    func setIcon(_ value: String) -> Self {
        self.icon = value
        return self
    }
    
    func setTitle(_ value: String) -> Self {
        self.title = value
        return self
    }
    
    func setValue(_ value: String) -> Self {
        self.value = value
        return self
    }
    
    func build() -> NavigationDrawerCellModel {
        return NavigationDrawerCellModel(
            action: action ?? .none,
            icon: icon ?? "",
            title: title ?? "",
            value: value ?? "")
    }
}

