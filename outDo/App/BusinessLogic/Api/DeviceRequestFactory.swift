//
//  DeviceRequestFactory.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Foundation
import Combine

protocol DeviceRequestFactory: AbstractRequestFactory {
    
    func save() -> AnyPublisher<AFDataResponse<DeviceSaveResponse>, Never>
}

final class DeviceRequestFactoryImpl: DeviceRequestFactory {
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: Config.shared.urlApi)!
    
    private let authRepository: AuthRepository
    private let deviceRepository: DeviceRepository
    private let profileRepository: ProfileRepository
    private weak var stopwatch: Stopwatch?
    
    init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue, stopwatch: Stopwatch?, repositoryFactory: RepositoryFactory) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.stopwatch = stopwatch
        self.authRepository = repositoryFactory.authRepository
        self.deviceRepository = repositoryFactory.deviceRepository
        self.profileRepository = repositoryFactory.profileRepository
    }
    
    func save() -> AnyPublisher<AFDataResponse<DeviceSaveResponse>, Never> {
        let request = DeviceSaveRequest(
            baseUrl: baseUrl,
            stopwatch: stopwatch,
            authRepository: authRepository,
            deviceRepository: deviceRepository,
            profileRepository: profileRepository)
        return self.request(request: request)
    }
}

