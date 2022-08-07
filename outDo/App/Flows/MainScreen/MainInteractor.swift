//
//  MainInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

protocol MainInteractor: AnyObject {
    
}

final class MainInteractorImpl: MainInteractor {
    
    weak var presenter: MainPresenter?
    
    init() {
        
    }
}
