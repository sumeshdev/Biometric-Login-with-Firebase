    //
    //  LoginViewModel.swift
    //  Swift Login
    //
    //  Created by Sumesh Vs on 03/07/21.
    //
    
    import Foundation
    
    class LoginViewModel: ObservableObject {
        @Published var credentials = Credentials()
        @Published var showProgressView = false
        @Published var error : Authentication.AuthenticationError?
        @Published var storeCredentials = false
        
        var loginDisabled: Bool {
            credentials.email.isEmpty || credentials.password.isEmpty
        }
        
        // MARK: - login model with keychain saving options
        
        func login(completion: @escaping (Bool) -> Void) {
            showProgressView = true
            APIService.shared.login(credentials: credentials) { [unowned self] (result: Result<Bool, Authentication.AuthenticationError>) in
                showProgressView = false
                switch result {
                case .success:
                    if KeychainDB.saveCredentials(credentials) {
                        storeCredentials = false
                    }
                    completion(true)
                case .failure (let authError):
                    credentials = Credentials()
                    completion(false)
                    error = authError
                    
                }
            }
        }
    }
