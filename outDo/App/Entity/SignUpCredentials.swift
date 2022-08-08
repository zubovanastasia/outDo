//
//  SignUpCredentials.swift
//  outDo
//
//  Created by Anastasiia Zubova on 07.08.2022.
//

import Foundation

struct SignUpCredentials: Codable {
    var login: String
    var password: String
    var name: String
    
    init(login: String) {
        self.init(login: login, password: "", name: "")
    }
    init(login: String, password: String, name: String) {
        self.login = login
        self.password = password
        self.name = name
    }
    init(_ json: [String:Any]? = nil) {
        login = json?["login"] as? String ?? ""
        password = json?["password"] as? String ?? ""
        name = json?["name"] as? String ?? ""
    }
    init(_ loginCredentials: SignUpCredentials) {
        login = loginCredentials.login
    }
}
extension SignUpCredentials {
    var data: Data? {
        get { return try? JSONEncoder().encode(self) }
    }
}

