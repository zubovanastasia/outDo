//
//  TaskPresenter.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

import UIKit

protocol TaskPresenter: AnyObject {
    
    // MARK: - Coordinator
    var onBack: VoidClosure? { get set }
    
    func setCells(_ cells: [TaskCellModel])
    func showAlert(_ alert: UIAlertController)
    func onTapStateButton()
    func updateData()
}

final class TaskPresenterImpl: TaskPresenter {
    
    // MARK: - Coordinator
    var onBack: VoidClosure?
    
    private var interactor: TaskInteractor
    weak var view: (UIViewController & TaskView)?
    
    init(interactor: TaskInteractor) {
        self.interactor = interactor
    }
    
    func setCells(_ cells: [TaskCellModel]) {
        view?.setCells(cells)
    }
    
    func onTapStateButton() {
        interactor.onTapStateButton()
    }
    
    func updateData() {
        view?.setTitle(Locales.value("vc_task_title")
                              .replacingFirstOccurrence(of: LocalesPattern.value, with: "\(interactor.taskId)"))
        view?.setTitleButton(Locales.valueFor(interactor.taskState))
        interactor.updateCells()
    }
    
    func showAlert(_ alert: UIAlertController) {
        view?.present(alert, animated: true, completion: nil)
    }
}
