//
//  TaskCreateInteractor.swift
//  outDo
//
//  Created by Антон Бондаренко on 26.08.2022.
//

import Combine
import Foundation

protocol TaskCreateInteractor: AnyObject {
    
    var task: Task { get }
    
    func onDidChangeTitle(_ value: String)
    func onDidChangeText(_ value: String)
    func onTapDate()
    func onTapSave()
}

final class TaskCreateInteractorImpl: TaskCreateInteractor {
    
    weak var presenter: TaskCreatePresenter?
    private var taskCreateProvider: TaskCreateProvider
    private var taskCancellable: AnyCancellable?
    var task: Task
    
    init(taskCreateProvider: TaskCreateProvider) {
        task = Task()
        self.taskCreateProvider = taskCreateProvider
    }
    
    func onDidChangeTitle(_ value: String) {
        task.title = value
    }
    
    func onDidChangeText(_ value: String) {
        task.text = value
    }
    
    func onTapDate() {
        DialogBuilder.shared.showDatePicker(date: task.fromDateDate) { [weak self] date in
            self?.task.fromDateDate = date
            self?.task.fromDateValue = date.timeIntervalSince1970 * 1000
            self?.task.fromDate = date.timestamp
            self?.presenter?.setDate()
        }
    }
    
    func onTapSave() {
        if task.title.isEmpty {
            DialogBuilder.shared.showToast(Locales.value("toast_taskCreate_noTitle"))
            return
        }
        if task.fromDateValue <= 0 {
            DialogBuilder.shared.showToast(Locales.value("toast_taskCreate_noDate"))
            return
        }
        taskCancellable = taskCreateProvider.taskCreate(task)
            .sink { [weak self] task in
                self?.presenter?.back()
            }
    }
}
