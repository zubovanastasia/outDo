//
//  DeviceProvider.swift
//  outDo
//
//  Created by Антон Бондаренко on 31.07.2022.
//

import UIKit
import Combine
import Alamofire

protocol DeviceProvider {
    
    var device: Device { get }
    var isBackground: Bool { get set }
    @discardableResult
    func save() -> AnyPublisher<AFDataResponse<DeviceSaveResponse>, Never>
}

class DeviceProviderImpl: DeviceProvider {
    
    private var deviceService: DeviceService
    
    init(deviceService: DeviceService) {
        self.deviceService = deviceService
    }
    
    var device: Device {
        get { return deviceService.device }
    }
    
    var isBackground: Bool {
        get { return deviceService.isBackground }
        set { deviceService.isBackground = newValue }
    }
    
    func save() -> AnyPublisher<AFDataResponse<DeviceSaveResponse>, Never> {
        return deviceService.save().eraseToAnyPublisher()
    }
}

