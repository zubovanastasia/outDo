//
//  TaskInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

import Foundation
import UIKit

protocol TaskInteractor: AnyObject {
    
    var taskId: Int { get }
    var taskState: TTaskState { get }
    func updateCells()
    func onTapStateButton()
}

final class TaskInteractorImpl: TaskInteractor {
    
    private var taskProvider: TaskProvider
    var taskId: Int
    weak var presenter: TaskPresenter?
    private var cells = [TaskCellModel]()
    
    init(taskProvider: TaskProvider, taskId: Int) {
        self.taskProvider = taskProvider
        self.taskId = taskId
    }
    
    var taskState: TTaskState {
        get { return taskProvider.getTask(by: taskId)?.state ?? TTaskState.created}
    }
    
    func updateCells() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            let cells = self?.construct() ?? [TaskCellModel]()
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.setCells(cells)
            }
        }
    }
    
    func onTapStateButton() {
        let alert = UIAlertController(title: "Изменить", message: "", preferredStyle: .actionSheet)
        let createdAction = UIAlertAction(
            title: "Новая",
            style: .default,
            handler: { [weak self] _ in
                self?.changeState(to: .created)
            })
        let processedAction = UIAlertAction(
            title: "Приступить к выполнению",
            style: .default,
            handler: { [weak self] _ in
                self?.changeState(to: .processed)
            })
        let completedAction = UIAlertAction(
            title: "Звершить",
            style: .default,
            handler: { [weak self] _ in
                self?.changeState(to: .completed)
            })
        let cancelledAction = UIAlertAction(
            title: "Отменить",
            style: .default,
            handler: { [weak self] _ in
                self?.changeState(to: .cancelled)
            })
        alert.addAction(createdAction)
        alert.addAction(processedAction)
        alert.addAction(completedAction)
        alert.addAction(cancelledAction)
        presenter?.showAlert(alert)
    }
    
    private func changeState(to state: TTaskState) {
        // TODO: . api change state
    }
}

// MARK: - Factory
extension TaskInteractorImpl {
    
    private func construct() -> [TaskCellModel] {
        guard let task = taskProvider.getTask(by: taskId) else {
            return []
        }
        var cells = [TaskCellModel]()
        cells.append(TaskCellModel(
            cell: TaskTitleCell.identifier,
            title: task.title,
            text: ""))
        let fromDate = task.fromDateValue > 0 ? task.fromDateDate.withFormat("EE, d MMM, HH:mm") : ""
        cells.append(TaskCellModel(
            cell: TaskDateCell.identifier,
            title: Locales.value("vc_task_fromDate"),
            text: fromDate))
        if !task.text.isEmpty {
            cells.append(TaskCellModel(
                cell: TaskDescriptionCell.identifier,
                title: Locales.value("vc_task_description"),
                text: task.text))
        }
        return cells
    }
}
