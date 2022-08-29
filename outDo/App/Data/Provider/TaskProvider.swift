//
//  TaskProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

protocol TaskProvider {
    
    func getTask(by id: Int) -> Task?
}

final class TaskProviderImpl: TaskProvider {
    
    private var taskService: TaskService
    
    init(taskService: TaskService) {
        self.taskService = taskService
    }
    
    func getTask(by id: Int) -> Task? {
        return taskService.getTask(by: id)
    }
}
