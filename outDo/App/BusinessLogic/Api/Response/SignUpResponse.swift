//
//  SignUpResponse.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

struct SignUpResponse: Codable {
    
    var result: SignUpResponseResult?
    var error: ApiResponseError?
}

struct SignUpResponseResult: Codable {
    
    var code: Int
}
