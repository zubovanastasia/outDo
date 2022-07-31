//
//  AuthRequestFactory.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Foundation

import Combine

protocol AuthRequestFactory: AbstractRequestFactory {
    
    func signInByPassword(with credentials: AuthCredentials) -> AnyPublisher<AFDataResponse<AuthSignInByPasswordResponse>, Never>
    func signOut() -> AnyPublisher<AFDataResponse<AuthSignOutResponse>, Never>
}

class AuthRequestFactoryImpl: AuthRequestFactory {
    
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
        self.authRepository = repositoryFactory.authRepository
        self.deviceRepository = repositoryFactory.deviceRepository
        self.profileRepository = repositoryFactory.profileRepository
        self.stopwatch = stopwatch
    }
    
    func signInByPassword(with credentials: AuthCredentials) -> AnyPublisher<AFDataResponse<AuthSignInByPasswordResponse>, Never> {
        let request = AuthSignInByPasswordRequest(
            baseUrl: baseUrl,
            stopwatch: stopwatch,
            authCredentials: credentials,
            deviceRepository: deviceRepository,
            profileRepository: profileRepository)
        ActivityHelper.shared.add(request.id)
        return self.request(request: request)
    }
    
    func signOut() -> AnyPublisher<AFDataResponse<AuthSignOutResponse>, Never> {
        let request = AuthSignOutRequest(
            baseUrl: baseUrl,
            stopwatch: stopwatch,
            authRepository: authRepository,
            deviceRepository: deviceRepository,
            profileRepository: profileRepository)
        return self.request(request: request)
    }
}

