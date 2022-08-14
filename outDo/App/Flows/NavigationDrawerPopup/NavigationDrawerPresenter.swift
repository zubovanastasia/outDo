//
//  NavigationDrawerPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

protocol NavigationDrawerPresenter: AnyObject {
    
    // MARK: Coordinator
    var completion: TActionClosure? { get set }
    
    func hide()
    func show()
}

final class NavigationDrawerPresenterImpl: NavigationDrawerPresenter {
    
    // MARK: Coordinator
    var completion: TActionClosure?
    
    private var interactor: NavigationDrawerInteractor
    weak var view: (UIViewController & NavigationDrawerView)?
    
    init(interactor: NavigationDrawerInteractor) {
        self.interactor = interactor
    }
    
    func hide() {
        
    }
    
    func show() {
        
    }
}
