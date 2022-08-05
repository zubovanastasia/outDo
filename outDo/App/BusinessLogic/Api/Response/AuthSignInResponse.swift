//
//  AuthSignInByPasswordResponseResult.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

struct AuthSignInResponse: Codable {
    
    var result: AuthSignInResponseResult?
    var error: ApiResponseError?
}

struct AuthSignInResponseResult: Codable {
    
    var code: Int
    var token: String
    var session: String
}
