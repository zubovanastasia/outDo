//
//  TasksGetResponse.swift
//  outDo
//
//  Created by Антон Бондаренко on 22.08.2022.
//

struct TasksGetResponse: Codable {
    
    var result: TasksGetResponseResult?
    var error: ApiResponseError?
}

struct TasksGetResponseResult: Codable {
    
    var tasks: [Task]
}
