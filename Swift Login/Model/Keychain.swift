//
//  Keychain.swift
//  Swift Login
//
//  Created by Sumesh Vs on 05/07/21.
//

import Foundation
import SwiftKeychainWrapper

// MARK: - Keychain Implementation
enum KeychainDB {
    static let key = "credentials"
    
    static func saveCredentials (_ credential: Credentials) -> Bool {
        if KeychainWrapper.standard.set(credential.encoded(), forKey: self.key){
            return true
        }else {
            return false
        }
    }
    
    static func fetchCredentials () -> Credentials? {
        if let credentialString = KeychainWrapper.standard.string(forKey: self.key) {
            return Credentials.decoded(credentialString)
        }else {
            return nil
        }
    }
    
    
    
}
