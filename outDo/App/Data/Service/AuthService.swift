//
//  AuthService.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Combine

protocol AuthService {
    
    var isAuthed: Bool { get }
    var credentials: AuthCredentials { get }
    
    func signIn(with credentials: AuthCredentials) -> AnyPublisher<(Bool, String?), Never>
    @discardableResult
    func signOut() -> AnyPublisher<(Bool, String?), Never>
}

class AuthServiceImpl: AuthService {
   
    private var authRepository: AuthRepository
    
    var isAuthed: Bool { return !authRepository.data.token.isEmpty }
    var credentials: AuthCredentials { get { return authRepository.data } }
    var requestFactory: RequestFactory
    private var anyCancellable: AnyCancellable?
    private var subject: PassthroughSubject<(Bool, String?), Never>
    
    init(authRepository: AuthRepository, requestFactory: RequestFactory) {
        self.authRepository = authRepository
        self.requestFactory = requestFactory
        subject = PassthroughSubject<(Bool, String?), Never>()
    }
   
    func signIn(with credentials: AuthCredentials) -> AnyPublisher<(Bool, String?), Never> {
        let authRequest = requestFactory.makeAuthRequestFactory()
        anyCancellable = authRequest.signIn(with: credentials)
            .sink { [weak self] data in
                ActivityHelper.shared.remove(data.request?.httpBody)
                if case .success(let response) = data.result {
                    guard let result = response.result else {
                        let message = response.error?.message ?? Locales.value("dialog_text_apiError_signInByPassword")
                        self?.subject.send((false, message))
                        return
                    }
                    self?.authRepository.data = AuthCredentials(credentials, result)
                    self?.subject.send((true, nil))
                }
            }
        return subject.eraseToAnyPublisher()
    }
    
    @discardableResult
    func signOut() -> AnyPublisher<(Bool, String?), Never> {
        let authRequest = requestFactory.makeAuthRequestFactory()
        anyCancellable = authRequest.signOut()
            .sink(receiveValue: { [weak self] data in
                self?.authRepository.data = AuthCredentials()
                self?.subject.send((false, nil))
            })
        return subject.eraseToAnyPublisher()
    }
}

