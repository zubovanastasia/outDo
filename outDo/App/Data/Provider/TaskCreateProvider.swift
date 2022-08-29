//
//  TaskCreateProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 27.08.2022.
//

import Alamofire
import Combine

protocol TaskCreateProvider {
    
    func taskCreate(_ task: Task) -> AnyPublisher<Task, Never>
}

final class TaskCreateProviderImpl: TaskCreateProvider {
    
    private var taskService: TaskCreateService
    
    init(taskService: TaskCreateService) {
        self.taskService = taskService
    }
    
    func taskCreate(_ task: Task) -> AnyPublisher<Task, Never> {
        return taskService.taskCreate(task)
    }
}
