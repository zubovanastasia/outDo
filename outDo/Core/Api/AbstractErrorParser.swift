//
//  AbstractErrorParser.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

protocol AbstractErrorParser {
    
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
