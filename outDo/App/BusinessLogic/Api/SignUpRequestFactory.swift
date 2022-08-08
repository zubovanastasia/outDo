//
//  SignUpRequestFactory.swift
//  outDo
//
//  Created by Anastasiia Zubova on 08.08.2022.
//

import Foundation
import Alamofire
import Combine

protocol SignUpRequestFactory: AbstractRequestFactory {
    
    func signUp(with credentials: SignUpCredentials) -> AnyPublisher<AFDataResponse<SignUpResponse>, Never>
}

class SignUpRequestFactoryImpl: SignUpRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: Config.shared.urlApi)!
    
    private let signUpRepository: SignUpRepository
    private let deviceRepository: DeviceRepository
    private let profileRepository: ProfileRepository
    private weak var stopwatch: Stopwatch?
    
    init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue, stopwatch: Stopwatch?, repositoryFactory: RepositoryFactory) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.signUpRepository = repositoryFactory.signUpRepository
        self.deviceRepository = repositoryFactory.deviceRepository
        self.profileRepository = repositoryFactory.profileRepository
        self.stopwatch = stopwatch
    }
    
    func signUp(with credentials: SignUpCredentials) -> AnyPublisher<AFDataResponse<SignUpResponse>, Never> {
        let request = SignUpRequest(
            baseUrl: baseUrl,
            stopwatch: stopwatch,
            authCredentials: <#AuthCredentials#>,
            signUpCredentials: credentials,
            deviceRepository: deviceRepository,
            profileRepository: profileRepository)
        ActivityHelper.shared.add(request.id)
        return self.request(request: request)
    }
}

