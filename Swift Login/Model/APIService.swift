//
//  APIService.swift
//  Swift Login
//
//  Created by Sumesh Vs on 02/07/21.
//

import Foundation
import FirebaseAuth

class APIService {
    
    static let shared = APIService()
   // MARK: - Firebase Login function
    
    let auth = Auth.auth()
    func login(credentials: Credentials, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            auth.signIn(withEmail: credentials.email, password: credentials.password) { result, error in
                if result != nil && error == nil {
                    completion(.success(true))
                } else {
                    completion(.failure(.invalidCredentials))
                }
            }
        }
    }
}



