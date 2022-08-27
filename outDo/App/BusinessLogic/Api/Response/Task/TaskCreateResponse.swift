//
//  TaskCreateResponse.swift
//  outDo
//
//  Created by Антон Бондаренко on 27.08.2022.
//

struct TaskCreateResponse: Codable {
    
    var result: TaskCreateResponseResult?
    var error: ApiResponseError?
}

struct TaskCreateResponseResult: Codable {
    
    var task: Task
}
