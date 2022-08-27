//
//  AuthStatusProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

protocol AuthStatusProvider: AnyObject {
    
    var isAuthed: Bool { get }
}

final class AuthStatusProviderImpl: AuthStatusProvider {
    
    private let authService: AuthService
    
    var isAuthed: Bool { authService.isAuthed }
    
    init(authService: AuthService) {
        self.authService = authService
    }
}
