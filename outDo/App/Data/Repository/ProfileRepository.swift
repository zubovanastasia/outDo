//
//  ProfileRepository.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

protocol ProfileRepository: AnyObject {
    
    var profile: Profile { get set }
    
    func clear()
}

final class ProfileRepositoryImpl: ProfileRepository {
    
    private var userDefaultsProvider: UserDefaultsProvider
    
    var profile: Profile {
        didSet {
            userDefaultsProvider.profile = profile
        }
    }
    
    init(userDefaultsProvider: UserDefaultsProvider) {
        self.userDefaultsProvider = userDefaultsProvider
        profile = userDefaultsProvider.profile
    }
    
    func clear() {
        profile = Profile()
    }
}

