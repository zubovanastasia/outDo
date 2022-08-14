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
    
    func signIn(with credentials: AuthCredentials) -> AnyPublisher<AFDataResponse<AuthSignInResponse>, Never>
    func signOut() -> AnyPublisher<AFDataResponse<AuthSignOutResponse>, Never>
    func signUp(with credentials: SignUpCredentials) -> AnyPublisher<AFDataResponse<AuthSignUpResponse>, Never>
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
    
    func signIn(with credentials: AuthCredentials) -> AnyPublisher<AFDataResponse<AuthSignInResponse>, Never> {
        let request = AuthSignInRequest(
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
    
    func signUp(with credentials: SignUpCredentials) -> AnyPublisher<AFDataResponse<AuthSignUpResponse>, Never> {
        let request = AuthSignUpRequest(
            baseUrl: baseUrl,
            stopwatch: stopwatch,
            credentials: credentials,
            deviceRepository: deviceRepository,
            profileRepository: profileRepository)
        ActivityHelper.shared.add(request.id)
        return self.request(request: request)
    }
}

