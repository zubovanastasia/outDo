//
//  RequestFactory.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//


import Alamofire
import Foundation

class RequestFactory {
    
    private let repositoryFactory: RepositoryFactory
    private weak var stopwatch: Stopwatch?
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 20
        return Session(configuration: configuration)
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    init(stopwatch: Stopwatch?, repositoryFactory: RepositoryFactory) {
        self.stopwatch = stopwatch
        self.repositoryFactory = repositoryFactory
    }
    
    func makeAuthRequestFactory() -> AuthRequestFactory {
        return AuthRequestFactoryImpl(
            errorParser: makeErrorParser(),
            sessionManager: commonSession,
            queue: sessionQueue,
            stopwatch: stopwatch,
            repositoryFactory: repositoryFactory)
    }
    
    func makeDeviceRequestFactory() -> DeviceRequestFactory {
        return DeviceRequestFactoryImpl(
            errorParser: makeErrorParser(),
            sessionManager: commonSession,
            queue: sessionQueue,
            stopwatch: stopwatch,
            repositoryFactory: repositoryFactory)
    }
    func makeProfileRequestFactory() -> ProfileRequestFactory {
        return ProfileRequestFactoryImpl(
            errorParser: makeErrorParser(),
            sessionManager: commonSession,
            queue: sessionQueue,
            stopwatch: stopwatch,
            repositoryFactory: repositoryFactory)
    }
    
    func makeTasksRequestFactory() -> TasksRequestFactory {
        return TasksRequestFactoryImpl(
            errorParser: makeErrorParser(),
            sessionManager: commonSession,
            queue: sessionQueue,
            stopwatch: stopwatch,
            repositoryFactory: repositoryFactory)
    }
}

