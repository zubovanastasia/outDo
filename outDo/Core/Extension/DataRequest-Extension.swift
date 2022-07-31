//
//  DataRequest-Extension.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Foundation

extension DataRequest {
    
    @discardableResult
    func responseCodable<T: Decodable>(errorParser: AbstractErrorParser,
                                       queue: DispatchQueue = .main,
                                       completion: @escaping (AFDataResponse<T>) -> Void) -> Self {
        let responseSerializer = CustomDecodableSerializer<T>(errorParser: errorParser)
        return response(
            queue: queue,
            responseSerializer: responseSerializer,
            completionHandler: completion)
    }
}
