//
//  LocalAuthentication.swift
//  Easy Numbers
//
//  Created by NJ Development on 15/07/23.
//

import Foundation
import UIKit
import LocalAuthentication

enum AuthPolicy {
    case canEvaluate
    case canNotEvaluate
    case canEvaluateError
}

final class LocalAuthentication {
    static let shared = LocalAuthentication()
    
    private init() {}
    
    func authenticateWithBiometrics(completion: @escaping (AuthPolicy) -> ()) {
        let context = LAContext()
        var error: NSError?
        let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        
        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: LocalizableStrings.faceID.localized) { success, error in
                guard error == nil else {
                    completion(.canEvaluateError)
                    return
                }
                completion(.canEvaluate)
            }
        } else {
            completion(.canNotEvaluate)
        }
    }
}
