//
//  MainPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

import UIKit

protocol MainPresenter: AnyObject {
    
    // MARK: - Coordinator
    var onHandleAction: ((TAction, Any?) -> Void)? { get set }
    
    func onTapAdd()
    func onTapMenu()
    func setCells(_ cells: [MainCellModel])
    func updateData()
    func viewDidAppear()
    func viewDidLoad()
}

final class MainPresenterImpl: MainPresenter {
    
    // MARK: - Coordinator
    var onHandleAction: ((TAction, Any?) -> Void)?
    
    private var interactor: MainInteractor
    weak var view: (UIViewController & MainView)?
    
    init(interactor: MainInteractor) {
        self.interactor = interactor
    }
    
    func onTapAdd() {
        interactor.onTapAdd()
    }
    
    func onTapMenu() {
        interactor.onTapMenu()
    }
    
    func setCells(_ cells: [MainCellModel]) {
        view?.setCells(cells)
    }
    
    func updateData() {
        interactor.updateCells()
        view?.setTitle(Locales.value("vc_main_title"))
    }
    
    func viewDidAppear() {
        interactor.viewDidAppear()
    }
    
    func viewDidLoad() {
        interactor.viewDidLoad()
    }
}
