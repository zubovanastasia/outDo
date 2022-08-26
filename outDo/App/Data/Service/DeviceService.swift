//
//  DeviceService.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import Combine
import Alamofire

protocol DeviceService {
    
    var isBackground: Bool { get set }
    var device: Device { get }
    
    func save() -> AnyPublisher<AFDataResponse<DeviceSaveResponse>, Never>
}

final class DeviceServiceImpl: DeviceService {
    
    private let authRepository: AuthRepository
    private let deviceRepository: DeviceRepository
    private let profileRepository: ProfileRepository
    private let requestFactory: RequestFactory
    
    init(repositoryFactory: RepositoryFactory, requestFactory: RequestFactory) {
        self.authRepository = repositoryFactory.authRepository
        self.deviceRepository = repositoryFactory.deviceRepository
        self.profileRepository = repositoryFactory.profileRepository
        self.requestFactory = requestFactory
    }
    
    var device: Device {
        get { return deviceRepository.device }
    }
    
    var isBackground: Bool {
        get { return deviceRepository.isBackground }
        set { deviceRepository.isBackground = newValue }
    }
    
    func save() -> AnyPublisher<AFDataResponse<DeviceSaveResponse>, Never> {
        let deviceRequest = requestFactory.makeDeviceRequestFactory()
        return deviceRequest.save().eraseToAnyPublisher()
    }
}

