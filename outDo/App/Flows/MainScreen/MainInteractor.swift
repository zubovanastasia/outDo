//
//  MainInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 05.08.2022.
//

protocol MainInteractor: AnyObject {
    
    func onTapNavbarMenu()
}

final class MainInteractorImpl: MainInteractor {
    
    weak var presenter: MainPresenter?
    
    func onTapNavbarMenu() {
        DialogBuilder.shared.showNavigationDrawer { [weak self] action in
            self?.presenter?.onHandleAction?(action, nil)
        }
    }
}
