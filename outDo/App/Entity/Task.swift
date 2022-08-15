//
//  Task.swift
//  outDo
//
//  Created by Ruslan Magomedov on 14.08.2022.
//

import Foundation

struct Task: Codable {
    
    var title: String
    var text: String
    var id: Int
    var state: Int
    var created: String (TimeStamp "yyy-mm-dd hh:mm:ss")
    var updated: String (TimeStamp "yyy-mm-dd hh:mm:ss")
    var group: TaskGroup
    var assignees: [Assignee]

    
    enum CodingKeys: String, CodingKey {
        case title
        case text
        case id
        case state
        case created, updated
        case group
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.created = (try? container.decode(String.self, forKey: .created)) ?? ""
        self.updated = (try? container.decode(String.self, forKey: .updated)) ?? ""
        self.title = (try? container.decode(String.self, forKey: .title)) ?? ""
        self.text = (try? container.decode(String.self, forKey: .text)) ?? ""
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.state = (try? container.decode(Int.self, forKey: .state)) ?? 0
    }
    
    init(_ json: [String:Any]? = nil) {
        created = json?["created"] as? String ?? "0000-00-00 00:00:00"
        updated = json?["updated"] as? String ?? "0000-00-00 00:00:00"
        id = Int(json?["id"])
        title = json?["title"] as? String ?? ""
        text = json?["text"] as? String ?? ""
        state = Int(json?["state"])
    }
    
    
    func getJson() -> [String:Any] {
        return [
            "created": created,
            "updated": updated,
            "id": id,
            "title": title,
            "text": text,
            "state": state
        ]
    }
}
