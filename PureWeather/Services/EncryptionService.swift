//
//  EncryptionService.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 18.07.2024.
//

import Foundation



final class EncryptionService {
    
    static func shared() -> EncryptionService {
        return EncryptionService()
    }
    
    func generateEncryptionKey() -> Data {
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        }
        return key
    }
    
    func getOrGenerateEncryptionKey() -> Data {
        guard let key = KeychainWrapper.standard.data(forKey: "EncryptionKey") else {
            let newKey = generateEncryptionKey()
            KeychainWrapper.standard.set(newKey, forKey: "EncryptionKey")
            return newKey
        }
        return key
    }
}

