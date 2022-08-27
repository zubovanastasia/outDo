//
//  TasksRepository.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//


protocol TasksRepository: AnyObject {
    
    var tasks: [Task] { get }
    
    func add(_ tasks: [Task])
    func add(_ task: Task)
    func clear()
}

final class TasksRepositoryImpl: TasksRepository {
    
    var tasks = [Task]()
    
    func add(_ tasks: [Task]) {
        self.tasks = tasks.sorted(by: { $0.fromDateValue < $1.fromDateValue })
    }
    
    func add(_ task: Task) {
        tasks.append(task)
        add(tasks)
    }
    
    func clear() {
        tasks = []
    }
}
