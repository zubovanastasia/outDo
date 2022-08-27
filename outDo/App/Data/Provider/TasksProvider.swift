//
//  TasksProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

import Alamofire
import Combine

protocol TasksProvider {
 
    var tasks: [Task] { get }
    func tasksGet() -> AnyPublisher<Bool, Never>
}

final class TasksProviderImpl: TasksProvider {
    
    var tasks: [Task] {
        get { return tasksService.tasks }
    }
    
    private let tasksService: TasksService
    
    init(tasksService: TasksService) {
        self.tasksService = tasksService
    }
    
    // MARK: - Api
    func tasksGet() -> AnyPublisher<Bool, Never> {
        return tasksService.tasksGet()
    }
}
