//
//  UserDefaultsProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Foundation

@propertyWrapper
struct MUserDefaultsManager<Value> {
    
    let key: String
    let container: UserDefaults = .standard

    var wrappedValue: Value? {
        get { return container.object(forKey: key) as? Value }
        set { container.set(newValue, forKey: key) }
    }
}

protocol UserDefaultsProvider {
    
    var profile: Profile { get set }
}

class UserDefaultsProviderImpl: UserDefaultsProvider {
    
    enum Keys {
        static let profile = "profile"
    }
    
    @MUserDefaultsManager(key: Keys.profile)
    private var _profile: [String:Any]?
    var profile: Profile {
        get { return Profile(_profile) }
        set { _profile = newValue.getJson() }
    }
}
