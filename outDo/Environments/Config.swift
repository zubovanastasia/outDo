//
//  Config.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit

class Config {
    
    static let shared = Config()

    let minCountPassword = 6
    let minCountPhoneCode = 4
    let maxCountPhoneNumber = 11
    let maxCountPhoneCode = 6

    let persistentContainerName = "outDo"
    
    let urlApi = "http://srv176287.hoster-test.ru/outDo/api/"
}
