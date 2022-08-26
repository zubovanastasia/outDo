//
//  TasksRepository.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//


protocol TasksRepository: AnyObject {
    
    var tasks: [Task] { get set }
    
    func clear()
}

final class TasksRepositoryImpl: TasksRepository {
    
    var tasks = [Task]()
    
    func clear() {
        tasks = []
    }
}
