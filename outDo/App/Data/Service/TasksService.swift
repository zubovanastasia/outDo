//
//  TasksService.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

protocol TasksService {
    
    var tasks: [Task] { get }
    
    func tasksGet(completion: @escaping (TasksGetResponse?) -> Void)
}

final class TasksServiceImpl: TasksService {
    
    private let authRepository: AuthRepository
    private let tasksRepository: TasksRepository
    private let requestFactory: RequestFactory
    
    init(repositoryFactory: RepositoryFactory, requestFactory: RequestFactory) {
        self.authRepository = repositoryFactory.authRepository
        tasksRepository = repositoryFactory.tasksRepository
        self.requestFactory = requestFactory
    }
    
    var tasks: [Task] {
        get { return tasksRepository.tasks }
    }
    
    func tasksGet(completion: @escaping (TasksGetResponse?) -> Void) {
        let tasksRequest = requestFactory.makeTasksRequestFactory()
        tasksRequest.tasksGet() { [weak self] data in
            ActivityHelper.shared.remove(data.request?.httpBody)
            if case .success(let response) = data.result {
                guard let result = response.result else {
                    completion(nil)
                    return
                }
                self?.tasksRepository.add(result.tasks)
                completion(response)
            }
        }
    }
}
