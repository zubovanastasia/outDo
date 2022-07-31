//
//  AuthSignInByPasswordResponseResult.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

struct AuthSignInByPasswordResponse: Codable {
    
    var result: AuthSignInByPasswordResponseResult?
    var error: ApiResponseError?
}

struct AuthSignInByPasswordResponseResult: Codable {
    
    var token: String
    var refreshToken: String
    var session: String
}
