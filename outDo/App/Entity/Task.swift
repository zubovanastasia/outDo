//
//  Task.swift
//  outDo
//
//  Created by Ruslan Magomedov on 14.08.2022.
//

import Foundation

struct Task: Codable {
    
    var assignee: Int//Assignee
    var created: String
    var createdValue: Double
    var createdDate: Date
    var estimatedTime: Int
    var fromDate: String
    var fromDateValue: Double
    var fromDateDate: Date
    var id: Int
    var state: TTaskState
    var text: String
    var title: String
    var updated: String
    var updatedValue: Double
    var updatedDate: Date
    
    enum CodingKeys: String, CodingKey {
        case assignee
        case created, createdValue, updated, updatedValue
        case estimatedTime
        case fromDate, fromDateValue
        case id
        case state
        case text, title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assignee = (try? container.decode(Int.self, forKey: .assignee)) ?? 0
        self.created = (try? container.decode(String.self, forKey: .created)) ?? ""
        self.createdValue = (try? container.decode(Double.self, forKey: .createdValue)) ?? 0
        self.estimatedTime = (try? container.decode(Int.self, forKey: .estimatedTime)) ?? 0
        self.fromDate = (try? container.decode(String.self, forKey: .fromDate)) ?? ""
        self.fromDateValue = (try? container.decode(Double.self, forKey: .fromDateValue)) ?? 0
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.state = (try? container.decode(TTaskState.self, forKey: .state)) ?? .created
        self.title = (try? container.decode(String.self, forKey: .title)) ?? ""
        self.text = (try? container.decode(String.self, forKey: .text)) ?? ""
        self.updated = (try? container.decode(String.self, forKey: .updated)) ?? ""
        self.updatedValue = (try? container.decode(Double.self, forKey: .updatedValue)) ?? 0
        
        createdDate = Date(timeIntervalSince1970: createdValue)
        fromDateDate = Date(timeIntervalSince1970: fromDateValue)
        updatedDate = Date(timeIntervalSince1970: updatedValue)
    }
    
    init(_ json: [String:Any]? = nil) {
        assignee = Int(json?["assignee"])
        created = json?["created"] as? String ?? "0000-00-00 00:00:00"
        createdValue = Double(json?["createdValue"])
        estimatedTime = Int(json?["estimatedTime"])
        fromDate = json?["fromDate"] as? String ?? "0000-00-00 00:00:00"
        fromDateValue = Double(json?["fromDateValue"])
        id = Int(json?["id"])
        state = TTaskState(rawValue: Int(json?["state"])) ?? .created
        title = json?["title"] as? String ?? ""
        text = json?["text"] as? String ?? ""
        updated = json?["updated"] as? String ?? "0000-00-00 00:00:00"
        updatedValue = Double(json?["updatedValue"])
        
        createdDate = Date(timeIntervalSince1970: createdValue)
        fromDateDate = Date(timeIntervalSince1970: fromDateValue)
        updatedDate = Date(timeIntervalSince1970: updatedValue)
    }
    
    
    func getJson() -> [String:Any] {
        return [
            "assignee": assignee,
            "created": created,
            "createdValue": createdValue,
            "estimatedTime": estimatedTime,
            "fromDate": fromDate,
            "fromDateValue": fromDateValue,
            "id": id,
            "state": state,
            "text": text,
            "title": title,
            "updated": updated,
            "updatedValue": updatedValue
        ]
    }
}
