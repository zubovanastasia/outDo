//
//  Assignee.swift
//  outDo
//
//  Created by Ruslan Magomedov on 14.08.2022.
//

import Foundation

struct Assignee: Codable {
    
    var id: Int
    var name: String
    var iconUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.iconUrl = (try? container.decode(String.self, forKey: .iconUrl)) ?? ""
    }
    
    init(_ json: [String:Any]? = nil) {
        id = Int(json?["id"])
        name = json?["name"] as? String ?? ""
        iconUrl = json?["iconUrl"] as? String ?? ""
    }
    
    func getJson() -> [String:Any] {
        return [
            "id": id,
            "name": name,
            "iconUrl": iconUrl
        ]
    }
}
