//
//  ProfileProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Combine

protocol ProfileProvider {
    
    var profile: Profile { get }
    
    func profileGet() -> AnyPublisher<Profile?, Never>
}

final class ProfileProviderImpl: ProfileProvider {
    
    var profile: Profile {
        get { return profileService.profile }
    }
    
    private let profileService: ProfileService
    
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    
    // MARK: - Api
    func profileGet() -> AnyPublisher<Profile?, Never> {
        return profileService.profileGet()
    }
}

