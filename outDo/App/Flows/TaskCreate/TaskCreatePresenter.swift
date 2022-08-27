//
//  TaskCreatePresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 26.08.2022.
//

import UIKit

protocol TaskCreatePresenter: AnyObject {
    
    // MARK: - Coordinator
    var onBack: VoidClosure? { get set }
}

final class TaskCreatePresenterImpl: TaskCreatePresenter {
    
    // MARK: - Coordinator
    var onBack: VoidClosure?
    
    private var interactor: TaskCreateInteractor
    weak var view: (UIViewController & TaskCreateView)?
    
    init(interactor: TaskCreateInteractor) {
        self.interactor = interactor
    }
}

