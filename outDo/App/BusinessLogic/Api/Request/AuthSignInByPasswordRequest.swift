//
//  AuthSignInByPasswordRequest.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Foundation

struct AuthSignInByPasswordRequest: RequestRouter {
    
    let id = NSUUID().uuidString
    var baseUrl: URL
    let httpMethod: HTTPMethod = .post
    let path: String = ""
    
    var action = ""
    let method = ApiMethod.signInByPassword
    var time = ""
    var signature = ""
    
    weak var stopwatch: Stopwatch?
    var authCredentials: AuthCredentials
    var deviceRepository: DeviceRepository
    var profileRepository: ProfileRepository
    
    init(baseUrl: URL, stopwatch: Stopwatch?, authCredentials: AuthCredentials, deviceRepository: DeviceRepository, profileRepository: ProfileRepository) {
        self.baseUrl = baseUrl
        self.stopwatch = stopwatch
        self.authCredentials = authCredentials
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
                    "username": authCredentials.login,
                    "token": authCredentials.token,
                    "time": time,
                    "signature": signature,
                    "clientInfo": deviceRepository.device.getJson()
                ]
            ]
        }
    }
}

