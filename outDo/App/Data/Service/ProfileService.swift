//
//  ProfileService.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

protocol ProfileService {
    
    var profile: Profile { get }
    
    func profileGet(completion: @escaping (ProfileGetResponse?) -> Void)
}

final class ProfileServiceImpl: ProfileService {
    
    private let authRepository: AuthRepository
    private var profileRepository: ProfileRepository
    private let requestFactory: RequestFactory
    
    init(repositoryFactory: RepositoryFactory, requestFactory: RequestFactory) {
        self.authRepository = repositoryFactory.authRepository
        self.profileRepository = repositoryFactory.profileRepository
        self.requestFactory = requestFactory
    }
    
    var profile: Profile {
        get { return profileRepository.profile }
    }
    
    func profileGet(completion: @escaping (ProfileGetResponse?) -> Void) {
        let profileRequest = requestFactory.makeProfileRequestFactory()
        profileRequest.profileGet() { [weak self] data in
            ActivityHelper.shared.remove(data.request?.httpBody)
            if case .success(let response) = data.result {
                guard let result = response.result else {
                    completion(nil)
                    return
                }
                self?.profileRepository.profile = result.profile
                completion(response)
            }
        }
    }
}
