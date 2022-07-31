//
//  AbstractRequestFactory.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Foundation
import Combine

protocol AbstractRequestFactory {
    
    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    
    @discardableResult
    func request<T: Decodable>(request: URLRequestConvertible, completion: @escaping (AFDataResponse<T>) -> Void) -> DataRequest
    
    @discardableResult
    func request<T: Decodable>(request: URLRequestConvertible) -> AnyPublisher<AFDataResponse<T>, Never>
}

extension AbstractRequestFactory {
    
    @discardableResult
    func request<T: Decodable>(request: URLRequestConvertible, completion: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
        return sessionManager.request(request)
            .responseCodable(
                errorParser: errorParser,
                completion: completion)
        
    }
    
    @discardableResult
    func request<T: Decodable>(request: URLRequestConvertible) -> AnyPublisher<AFDataResponse<T>, Never> {
        return sessionManager.request(request)
            .publishDecodable(type: T.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

