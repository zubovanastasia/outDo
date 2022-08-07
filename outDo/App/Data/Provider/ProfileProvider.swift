//
//  ProfileProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

protocol ProfileProvider {
    
    var profile: Profile { get }
    
    func profileGet(completion: @escaping (ProfileGetResponse?) -> Void)
}

class ProfileProviderImpl: ProfileProvider {
    
    var profile: Profile {
        get { return profileService.profile }
    }
    
    private let profileService: ProfileService
    
    init(profileService: ProfileService) {
        self.profileService = profileService
    }
    
    // MARK: - Api
    func profileGet(completion: @escaping (ProfileGetResponse?) -> Void) {
        profileService.profileGet(completion: completion)
    }
}

