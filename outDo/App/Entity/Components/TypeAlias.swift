//
//  TypeAlias.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Foundation

typealias VoidClosure = () -> Void
typealias BoolClosure = (Bool) -> Void
typealias DateClosure = (Date) -> Void
typealias DoubleClosure = (Double) -> Void
typealias StringClosure = (String) -> Void

typealias TActionClosure = (TAction) -> Void
typealias TActionAnyClosure = (TAction, Any?) -> Void
