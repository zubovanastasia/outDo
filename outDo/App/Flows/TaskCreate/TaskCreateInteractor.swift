//
//  TaskCreateInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 26.08.2022.
//

import Foundation

protocol TaskCreateInteractor: AnyObject {
    
}

final class TaskCreateInteractorImpl: TaskCreateInteractor {
    
    weak var presenter: TaskCreatePresenter?
    
    init() {}
}
