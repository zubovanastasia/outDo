//
//  ApiError.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

enum ApiError: Error, CustomStringConvertible {
    
    case missingHttpResponse
    case unexptectedResponse(Int)
    case parseError(String)
    case undefinedError
    case internalError
    
    var description: String {
        switch self {
        case .missingHttpResponse: return "Missing HTTP response"
        case .unexptectedResponse(let code): return "Code should be 2xx, but is \(code)"
        case .parseError(let message): return "Undefined server error. \(message)"
        case .undefinedError: return "Undefinded server error"
        case .internalError: return ""
        }
    }
}
