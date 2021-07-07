//
//  Credentials.swift
//  Swift Login
//
//  Created by Sumesh Vs on 02/07/21.
//

import Foundation

struct Credentials : Codable {
    var email : String = ""
    var password : String = ""
    // MARK: - For Keychain We need to encode the give password to store in keychain & Decode to use it
    func encoded() -> String{
        let encoder = JSONEncoder()
        let credentialsData = try! encoder.encode(self)
        return String(data: credentialsData, encoding: .utf8)!
    }
    
    static func decoded(_ credentialsString: String) -> Credentials {
        let decoder = JSONDecoder()
        let jsonData = credentialsString.data(using: .utf8)
        return try! decoder.decode((Credentials.self), from: jsonData!)
    }
    
}
