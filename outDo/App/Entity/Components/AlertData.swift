//
//  AlertData.swift
//  outDo
//
//  Created by Антон Бондаренко on 14.08.2022.
//

struct AlertData {

    let title: String
    let text: String
    let buttons: [AlertButtonData]
}

struct AlertButtonData {

    let title: String
    let completion: VoidClosure?
}
