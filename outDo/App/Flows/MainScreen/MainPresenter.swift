//
//  MainPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

import UIKit

protocol MainPresenter: AnyObject {
    
}

final class MainPresenterImpl: MainPresenter {
    
    private var interactor: MainInteractor
    weak var view: (UIViewController & MainView)?
    
    init(interactor: MainInteractor) {
        self.interactor = interactor
    }
}
