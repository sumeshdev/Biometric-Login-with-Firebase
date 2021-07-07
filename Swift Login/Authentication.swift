//
//  Authentication.swift
//  Swift Login
//
//  Created by Sumesh Vs on 04/07/21.
//

import SwiftUI
import LocalAuthentication

class Authentication: ObservableObject {
    @Published var isValidated = false
    @Published var isAuthorized = false
    
    // MARK: - Biometric enum
    enum BiometricType {
        case none
        case touchID
        case faceID
    }
    
    // MARK: - Error Catching and Validation with alerts
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case deniedAccess
        case faceIDNotEnrolled
        case fingerprintNotEnrolled
        case biometricError
        case unSavedCredential
        
        var id : String {
            self.localizedDescription
        }
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Invalid Username or Password", comment: "")
            case .deniedAccess:
                return NSLocalizedString("You denied Access. Please go to settings and find our app turn on Face ID or Touch ID", comment: "")
            case .faceIDNotEnrolled:
                return NSLocalizedString("You have not Enrolled your face ID yet", comment: "")
            case .fingerprintNotEnrolled:
                return NSLocalizedString("You have not Enrolled your touch ID yet", comment: "")
            case .biometricError:
                return NSLocalizedString("Your Touch ID or Face ID not recognized", comment: "")
            case .unSavedCredential:
                return NSLocalizedString("You Credentials are not saved would you like to save it in next Attempt?", comment: "")
            }
        }
    }
   
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
    // MARK: - Biometric Implementation
    
    func biometricType() -> BiometricType {
        let authenticContext = LAContext()
        let _ = authenticContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch authenticContext.biometryType {
        
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        @unknown default:
            return .none
        }
    }
    
    func biometricUnlock(completion: @escaping (Result<Credentials, AuthenticationError>) -> Void) {

        let credentials = KeychainDB.fetchCredentials()
        guard let credentials = credentials else {
        completion(.failure(.unSavedCredential))
        return
    }
        let context = LAContext()
        var error: NSError?
        let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            switch error.code {
            case -6:
                completion(.failure(.deniedAccess))
            case -7:
                if context.biometryType == .faceID {
                    completion(.failure(.faceIDNotEnrolled))
                }else {
                    completion(.failure(.fingerprintNotEnrolled))
                }
            default:
                completion(.failure(.biometricError))
            }
            return
        }
        if canEvaluate{
            if context.biometryType != .none {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Need to access Your credentials") { success, error in
                    DispatchQueue.main.async {
                        if error != nil {
                            completion(.failure(.biometricError))
                        }else{
                            completion(.success(credentials))
                        }
                        
                    }
                }
            }
        }
    }
    
}
