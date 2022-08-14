//
//  WebInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

protocol WebInteractor: AnyObject {
    
    var source: String { get }
    var title: String { get }
}

final class WebInteractorImpl: WebInteractor {
    
    private var data: WebData
    weak var presenter: WebPresenter?
    
    init(data: WebData) {
        self.data = data
    }
    
    var source: String {
        get { return data.url }
    }
    
    var title: String {
        get { return data.title }
    }
}
