//
//  LocalAuthentication.swift
//  Easy Numbers
//
//  Created by NJ Development on 15/07/23.
//

import Foundation
import UIKit
import LocalAuthentication

final class LocalAuthentication {
    static let shared = LocalAuthentication()
    
    private init() {}
    
    func authenticateWithBiometrics(completion: @escaping (Bool) -> ()) {
        let context = LAContext()
        var error: NSError?
        let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        
        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: "Liberar jogos salvos?") { success, error in
                guard error == nil else {
                    // MARK: - GIVE SOME ERROR BACK
                    return
                }
                completion(true)
            }
        } else {
            guard let error = error else { return }
            completion(false)
            UserDefaults.standard.setValue(false, forKey: "safetySwitch")
        }
    }
}
