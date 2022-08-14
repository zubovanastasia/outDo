//
//  MainPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

import UIKit

protocol MainPresenter: AnyObject {
    
    // MARK: - Coordinator
    var onHandleAction: ((TAction, Any?) -> Void)? { get set }
    
    func onTapNavbarMenu()
}

final class MainPresenterImpl: MainPresenter {
    
    // MARK: - Coordinator
    var onHandleAction: ((TAction, Any?) -> Void)?
    
    private var interactor: MainInteractor
    weak var view: (UIViewController & MainView)?
    
    init(interactor: MainInteractor) {
        self.interactor = interactor
    }
    
    func onTapNavbarMenu() {
        interactor.onTapNavbarMenu()
    }
}
