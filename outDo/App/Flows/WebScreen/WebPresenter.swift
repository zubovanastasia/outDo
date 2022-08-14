//
//  WebPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

import UIKit

protocol WebPresenter: AnyObject {
    
    // MARK: Coordinator
    var onBack: VoidClosure? { get set }
    
    func updateData()
}

final class WebPresenterImpl: WebPresenter {
    
    // MARK: Coordinator
    var onBack: VoidClosure?
    
    private var interactor: WebInteractor
    weak var view: (UIViewController & WebView)?
    
    init(interactor: WebInteractor) {
        self.interactor = interactor
    }
    
    func updateData() {
        view?.setTitle(interactor.title.uppercased())
        guard let url = URL(string: interactor.source) else { return }
        let request: URLRequest = URLRequest(url: url)
        view?.load(request)
    }
}
