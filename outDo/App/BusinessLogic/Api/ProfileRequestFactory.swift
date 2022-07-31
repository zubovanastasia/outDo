//
//  ProfileRequestFactory.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Foundation

typealias ApiProfileGetResponseClosure = (AFDataResponse<ProfileGetResponse>) -> Void

protocol ProfileRequestFactory: AbstractRequestFactory {
    
    func profileGet(completion: @escaping ApiProfileGetResponseClosure)
}

class ProfileRequestFactoryImpl: ProfileRequestFactory {
    
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
    
    func profileGet(completion: @escaping ApiProfileGetResponseClosure) {
        let request = ProfileGetRequest(
            baseUrl: baseUrl,
            stopwatch: stopwatch,
            authRepository: authRepository,
            deviceRepository: deviceRepository,
            profileRepository: profileRepository)
        self.request(request: request, completion: completion)
        ActivityHelper.shared.add(request.id)
    }
}

