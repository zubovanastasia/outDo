//
//  SignUpResponse.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

struct AuthSignUpResponse: Codable {
    
    var result: AuthSignUpResponseResult?
    var error: ApiResponseError?
}

struct AuthSignUpResponseResult: Codable {
    
    var code: Int
}
