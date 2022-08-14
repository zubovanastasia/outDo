//
//  SignUpRequest.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

import Foundation
import Alamofire

struct AuthSignUpRequest: RequestRouter {
    
    let id = NSUUID().uuidString
    var baseUrl: URL
    let httpMethod: HTTPMethod = .post
    let path: String = ""
    var action = ""
    let method = ApiMethod.signUp
    var time = ""
    var signature = ""
    
    weak var stopwatch: Stopwatch?
    var authCredentials: AuthCredentials = AuthCredentials()
    var credentials: SignUpCredentials
    var deviceRepository: DeviceRepository
    var profileRepository: ProfileRepository
    
    init(baseUrl: URL, stopwatch: Stopwatch?, credentials: SignUpCredentials, deviceRepository: DeviceRepository, profileRepository: ProfileRepository) {
        self.baseUrl = baseUrl
        self.stopwatch = stopwatch
        self.credentials = credentials
        self.deviceRepository = deviceRepository
        self.profileRepository = profileRepository
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
                    "user": credentials.getJson(),
                    "time": time,
                    "clientInfo": deviceRepository.device.getJson()
                ]
            ]
        }
    }
}

