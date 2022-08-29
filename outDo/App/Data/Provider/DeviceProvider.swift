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
    var isIpad: Bool { get }
    @discardableResult
    func save() -> AnyPublisher<AFDataResponse<DeviceSaveResponse>, Never>
}

final class DeviceProviderImpl: DeviceProvider {
    
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
    
    var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    func save() -> AnyPublisher<AFDataResponse<DeviceSaveResponse>, Never> {
        return deviceService.save().eraseToAnyPublisher()
    }
}

