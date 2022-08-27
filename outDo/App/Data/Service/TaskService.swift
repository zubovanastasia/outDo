//
//  TaskService.swift
//  outDo
//
//  Created by Антон Бондаренко on 27.08.2022.
//

import Alamofire
import Combine

protocol TaskService {
    
    func taskCreate(_ task: Task) -> AnyPublisher<Task, Never>
}

final class TaskServiceImpl: TaskService {
    
    private let authRepository: AuthRepository
    private let tasksRepository: TasksRepository
    private let requestFactory: RequestFactory
    private var anyCancellable: AnyCancellable?
    private var subject: PassthroughSubject<Task, Never>
    
    init(repositoryFactory: RepositoryFactory, requestFactory: RequestFactory) {
        self.authRepository = repositoryFactory.authRepository
        self.tasksRepository = repositoryFactory.tasksRepository
        self.requestFactory = requestFactory
        subject = PassthroughSubject<Task, Never>()
    }
    
    func taskCreate(_ task: Task) -> AnyPublisher<Task, Never> {
        let taskRequest = requestFactory.makeTaskRequestFactory()
        anyCancellable = taskRequest.taskCreate(task)
            .sink { [weak self] data in
                ActivityHelper.shared.remove(data.request?.httpBody)
                if case .success(let response) = data.result {
                    guard let result = response.result else { return }
                    self?.tasksRepository.add(result.task)
                    self?.subject.send(result.task)
                }
            }
        return subject.eraseToAnyPublisher()
    }
}
