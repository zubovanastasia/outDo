//
//  AuthProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Combine

protocol AuthProvider {
    
    var isAuthed: Bool { get }
    
    func signIn(with credentials: AuthCredentials) -> AnyPublisher<(Bool, String?), Never>
    @discardableResult
    func signOut() -> AnyPublisher<(Bool, String?), Never>
}

final class AuthProviderImpl: AuthProvider {
    
    var isAuthed: Bool { return authService.isAuthed }
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signIn(with credentials: AuthCredentials) -> AnyPublisher<(Bool, String?), Never> {
        return authService.signIn(with: credentials)
    }
    
    @discardableResult
    func signOut() -> AnyPublisher<(Bool, String?), Never> {
        return authService.signOut()
    }
}

