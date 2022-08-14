//
//  Profile.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

struct Profile: Codable {
    
    var email: String
    var name: String
    var icon: String
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = (try? container.decode(String.self, forKey: .email)) ?? ""
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.icon = (try? container.decode(String.self, forKey: .icon)) ?? ""
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
    }
    
    init(_ json: [String:Any]? = nil) {
        id = Int(json?["id"])
        name = json?["name"] as? String ?? ""
        email = json?["email"] as? String ?? ""
        icon = json?["icon"] as? String ?? ""
    }
    
    func getJson() -> [String:Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "icon": icon
        ]
    }
}

