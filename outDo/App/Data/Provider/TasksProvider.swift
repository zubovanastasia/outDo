//
//  TasksProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

protocol TasksProvider {
 
    var tasks: [Task] { get }
    func tasksGet(completion: @escaping (TasksGetResponse?) -> Void)
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
    func tasksGet(completion: @escaping (TasksGetResponse?) -> Void) {
        tasksService.tasksGet(completion: completion)
    }
}
