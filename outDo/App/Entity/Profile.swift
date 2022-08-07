//
//  Profile.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

struct Profile: Codable {
    
    var birthday: String
    var birthdayValue: Double
    var birthdayDate: Date?
    var email: String
    var firstName: String
    var icon: String
    var id: Int
    var lastName: String
    var phone: String
    var state: Int
    
    enum CodingKeys: String, CodingKey {
        case birthday, birthdayValue
        case id
        case firstName, lastName
        case email, phone
        case state
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.birthday = (try? container.decode(String.self, forKey: .birthday)) ?? ""
        self.birthdayValue = (try? container.decode(Double.self, forKey: .birthdayValue)) ?? 0
        self.birthdayDate = birthdayValue.date
        self.email = (try? container.decode(String.self, forKey: .email)) ?? ""
        self.firstName = (try? container.decode(String.self, forKey: .firstName)) ?? ""
        self.icon = (try? container.decode(String.self, forKey: .icon)) ?? ""
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.lastName = (try? container.decode(String.self, forKey: .lastName)) ?? ""
        self.phone = (try? container.decode(String.self, forKey: .phone)) ?? ""
        self.state = (try? container.decode(Int.self, forKey: .state)) ?? 0
    }
    
    init(_ json: [String:Any]? = nil) {
        birthday = json?["birthday"] as? String ?? "0000-00-00 00:00:00"
        birthdayValue = Double(json?["birthdayValue"])
        birthdayDate = json?["birthdayValue"] != nil ? birthdayValue.date : nil
        id = Int(json?["id"])
        firstName = json?["firstName"] as? String ?? ""
        lastName = json?["lastName"] as? String ?? ""
        email = json?["email"] as? String ?? ""
        phone = json?["phone"] as? String ?? ""
        state = Int(json?["state"])
        icon = json?["icon"] as? String ?? ""
    }
    
    var fullName: String {
        get { self.firstName + " " + self.lastName }
    }
    
    func getJson() -> [String:Any] {
        return [
            "birthday": birthday,
            "birtdayValue": birthdayValue,
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phone": phone,
            "state": state,
            "icon": icon
        ]
    }
}

