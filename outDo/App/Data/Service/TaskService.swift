//
//  TaskService.swift
//  outDo
//
//  Created by Антон Бондаренко on 29.08.2022.
//

protocol TaskService {
    
    func getTask(by id: Int) -> Task?
}

final class TaskServiceImpl: TaskService {
    
    private let tasksRepository: TasksRepository
    private let requestFactory: RequestFactory
    
    init(repositoryFactory: RepositoryFactory, requestFactory: RequestFactory) {
        self.tasksRepository = repositoryFactory.tasksRepository
        self.requestFactory = requestFactory
    }
    
    func getTask(by id: Int) -> Task? {
        return tasksRepository.getTask(by: id)
    }
}
