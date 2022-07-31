//
//  Locales.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

class Locales {
    
    static var current = "ru_RU"
    static var currentShort = "ru" // for picker
    
    static func value(_ key: String) -> String {
        return data[key] ?? ""
    }
    
    static private let data: [String:String] = [
        "vc_login_login": "Логин (почта)",
        "vc_login_password": "Пароль",
        "vc_login_signIn": "Войти"
        
//        "vc_critical_title": "Sorry, critical data error",
//        "vc_critical_title_internet": "No Internet connection available",
//
//
//        "vc_profile_title": "PROFILE",
//        "vc_profile_prompt_email": "Email",
//        "vc_profile_prompt_firstname": "First name",
//        "vc_profile_prompt_lastname": "Last name",
//        "vc_profile_prompt_birthday": "Birthday",
//        "vc_profile_prompt_phone": "Phone"
    ]
}

// ‒
// •
// →
