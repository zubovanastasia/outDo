//
//  ApiResponseError.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

struct ApiResponseError: Codable {
    
    var code: Int
    var message: String
}
