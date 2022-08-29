//
//  TasksService.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

import Alamofire
import Combine

protocol TasksService {
    
    var tasks: [Task] { get }
    
    func tasksGet() -> AnyPublisher<Bool, Never>
}

final class TasksServiceImpl: TasksService {
    
    private let tasksRepository: TasksRepository
    private let requestFactory: RequestFactory
    private var anyCancellable: AnyCancellable?
    private var subject: PassthroughSubject<Bool, Never>
    
    init(repositoryFactory: RepositoryFactory, requestFactory: RequestFactory) {
        tasksRepository = repositoryFactory.tasksRepository
        self.requestFactory = requestFactory
        subject = PassthroughSubject<Bool, Never>()
    }
    
    var tasks: [Task] {
        get { return tasksRepository.tasks }
    }
    
    func tasksGet() -> AnyPublisher<Bool, Never> {
        let tasksRequest = requestFactory.makeTasksRequestFactory()
        anyCancellable = tasksRequest.tasksGet()
            .sink { [weak self] data in
                ActivityHelper.shared.remove(data.request?.httpBody)
                if case .success(let response) = data.result {
                    guard let result = response.result else {
                        self?.subject.send(false)
                        return
                    }
                    self?.tasksRepository.add(result.tasks)
                    self?.subject.send(true)
                }
            }
        return subject.eraseToAnyPublisher()
    }
}
