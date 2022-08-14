//
//  NavigationDrawerPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

protocol NavigationDrawerPresenter: AnyObject {
    
    var completion: TActionAnyClosure? { get set }
    var isOpened: Bool { get set }
    
    func show()
    func hide()
    
    func onTapAction(_ action: TAction, _ data: NavigationDrawerCellModel?)
    func setCells(_ cells: [NavigationDrawerCellModel])
    func updateData()
}

final class NavigationDrawerPresenterImpl: NavigationDrawerPresenter {
    
    var completion: TActionAnyClosure?
    var isOpened: Bool = true {
        didSet {
            view?.animateDrawer(isOpened)
        }
    }
    
    private var interactor: NavigationDrawerInteractor
    weak var view: (UIViewController & NavigationDrawerView)?
    
    init(interactor: NavigationDrawerInteractor) {
        self.interactor = interactor
    }
    
    func show() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
            self?.isOpened = true
        }
        updateData()
    }
    
    func hide() {
        self.isOpened = false
    }

    func onTapAction(_ action: TAction, _ data: NavigationDrawerCellModel?) {
        interactor.onTapAction(action, data)
    }
    
    func setCells(_ cells: [NavigationDrawerCellModel]) {
        view?.setCells(cells)
    }
    
    func updateData() {
        view?.setTitleAccount(interactor.getName())
        view?.setTitleName(interactor.getEmail())
        interactor.updateCells()
    }
}

