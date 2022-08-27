//
//  ProfileService.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Alamofire
import Combine

protocol ProfileService {
    
    var profile: Profile { get }
    
    func profileGet() -> AnyPublisher<Profile?, Never>
}

final class ProfileServiceImpl: ProfileService {
    
    private let authRepository: AuthRepository
    private var profileRepository: ProfileRepository
    private let requestFactory: RequestFactory
    private var anyCancellable: AnyCancellable?
    private var subject: PassthroughSubject<Profile?, Never>
    
    init(repositoryFactory: RepositoryFactory, requestFactory: RequestFactory) {
        self.authRepository = repositoryFactory.authRepository
        self.profileRepository = repositoryFactory.profileRepository
        self.requestFactory = requestFactory
        subject = PassthroughSubject<Profile?, Never>()
    }
    
    var profile: Profile {
        get { return profileRepository.profile }
    }
    
    func profileGet() -> AnyPublisher<Profile?, Never> {
        let profileRequest = requestFactory.makeProfileRequestFactory()
        anyCancellable = profileRequest.profileGet()
            .sink { [weak self] data in
                ActivityHelper.shared.remove(data.request?.httpBody)
                if case .success(let response) = data.result {
                    guard let result = response.result else {
                        self?.subject.send(nil)
                        return
                    }
                    self?.profileRepository.profile = result.profile
                    self?.subject.send(result.profile)
                }
            }
        return subject.eraseToAnyPublisher()
    }
}
