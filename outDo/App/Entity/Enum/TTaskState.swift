//
//  TTaskState.swift
//  outDo
//
//  Created by Антон Бондаренко on 27.08.2022.
//

enum TTaskState: Int, Codable {
    
    case created = 1
    case processed = 2
    case completed = 4
    case cancelled = 8
}
