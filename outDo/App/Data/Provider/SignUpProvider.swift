//
//  SignUpProvider.swift
//  outDo
//
//  Created by Anastasiia Zubova on 08.08.2022.
//

import Combine

protocol SignUpProvider {
    
    func signUp(with credentials: SignUpCredentials) -> AnyPublisher<(Bool, String?), Never>
}

class SignUpProviderImpl: SignUpProvider {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signUp(with credentials: SignUpCredentials) -> AnyPublisher<(Bool, String?), Never> {
        return authService.signUp(with: credentials)
    }
}
