//
//  SignUpRepository.swift
//  outDo
//
//  Created by Anastasiia Zubova on 08.08.2022.
//

import Foundation

protocol SignUpRepository: AnyObject{
    
    var data: SignUpCredentials { get set }
    func clear()
}

class SignUpRepositoryImpl: SignUpRepository {
    private let keyChainKey = "signUp"
    private var keychainWrapper: KeychainWrapper
    var data: SignUpCredentials {
        get {
            if let data = keychainWrapper.data(forKey: keyChainKey),
               let credentials = try? JSONDecoder().decode(SignUpCredentials.self, from: data) {
                return credentials
            }
            return SignUpCredentials()
        }
        set {
            if let data = newValue.data {
                keychainWrapper.set(data, forKey: keyChainKey)
            }
            else {
                keychainWrapper.removeObject(forKey: keyChainKey)
            }
        }
    }
    init(keychainWrapper: KeychainWrapper) {
        self.keychainWrapper = keychainWrapper
        // MARK: - Debug setting
        if Config.alwaysAuth {
            clear()
        }
    }
    func clear() {
        data = SignUpCredentials()
    }
}
