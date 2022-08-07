//
//  AuthCredentials.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

struct AuthCredentials: Codable {
    
    var login: String
    var password: String
    var token: String
    var session: String
    
    init(login: String) {
        self.init(login: login, password: "")
    }
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
        self.token = ""
        self.session = ""
    }
    
    init(_ json: [String:Any]? = nil) {
        login = json?["login"] as? String ?? ""
        password = json?["password"] as? String ?? ""
        token = json?["token"] as? String ?? ""
        session = json?["session"] as? String ?? ""
    }
    
    init(_ loginCredentials: AuthCredentials, _ tokenCredentials: AuthSignInResponseResult) {
        login = loginCredentials.login
        password = loginCredentials.password
        token = tokenCredentials.token
        session = tokenCredentials.session
    }
    
}

// MARK: - Data
extension AuthCredentials {
    
    var data: Data? {
        get { return try? JSONEncoder().encode(self) }
    }
}
