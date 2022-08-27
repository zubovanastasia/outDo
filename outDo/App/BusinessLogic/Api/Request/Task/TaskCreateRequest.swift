//
//  TaskCreateRequest.swift
//  outDo
//
//  Created by Антон Бондаренко on 27.08.2022.
//

import Alamofire
import Foundation

struct TaskCreateRequest: RequestRouter {
    
    let id = NSUUID().uuidString
    var baseUrl: URL
    let httpMethod: HTTPMethod = .post
    let path: String = ""
    
    var action = ""
    let method = ApiMethod.taskCreate
    var time = ""
    var signature = ""
    
    weak var stopwatch: Stopwatch?
    var authCredentials: AuthCredentials
    var deviceRepository: DeviceRepository
    var profileRepository: ProfileRepository
    var task: Task
    
    init(baseUrl: URL, stopwatch: Stopwatch?, authRepository: AuthRepository, deviceRepository: DeviceRepository, profileRepository: ProfileRepository, task: Task) {
        self.baseUrl = baseUrl
        self.stopwatch = stopwatch
        self.authCredentials = authRepository.data
        self.deviceRepository = deviceRepository
        self.profileRepository = profileRepository
        self.task = task
        self.time = getTime()
        self.signature = getSignature()
    }
    
    var parameters: Parameters? {
        get {
            return [
                "jsonrpc": "2.0",
                "id": id,
                "method": method,
                "action": action,
                "params": [
                    "token": authCredentials.token,
                    "time": time,
                    "signature": signature,
                    "clientInfo": deviceRepository.device.getJson(),
                    "task": task.getJson()
                ]
            ]
        }
    }
}
