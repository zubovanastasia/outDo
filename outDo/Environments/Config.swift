//
//  Config.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit

final class Config {
    
    static let shared = Config()

    // MARK: - Debug for clear auth
    //static let alwaysAuth = true
    static let alwaysAuth = false
    
    let minCountPassword = 6
    let minCountPhoneCode = 4
    let maxCountPhoneNumber = 11
    let maxCountPhoneCode = 6

    let persistentContainerName = "outDo"
    
    let urlApi = "http://srv176287.hoster-test.ru/outdo/api/"
    let urlPolicy = "http://srv176287.hoster-test.ru/outdo/policy/app_confidence_ru.html"
}
