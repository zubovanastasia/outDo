//
//  TaskGroup.swift
//  outDo
//
//  Created by Ruslan Magomedov on 14.08.2022.
//

import Foundation

struct TaskGroup: Codable {
    

    var id: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
    }
    
    init(_ json: [String:Any]? = nil) {
        id = Int(json?["id"])
    }
    
    
    func getJson() -> [String:Any] {
        return [
            "id": id,

        ]
    }
}
