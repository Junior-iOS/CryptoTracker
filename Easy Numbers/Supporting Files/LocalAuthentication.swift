//
//  LocalAuthentication.swift
//  Easy Numbers
//
//  Created by NJ Development on 15/07/23.
//

import Foundation
import LocalAuthentication
import UIKit

enum AuthPolicy {
    case canEvaluate
    case canNotEvaluate
    case canEvaluateError
}

final class LocalAuthentication {
    static let shared = LocalAuthentication()

    private init() {}

    func authenticateWithBiometrics(completion: @escaping (AuthPolicy) -> Void) {
        let context = LAContext()
        var error: NSError?
        let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics

        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: LocalizableStrings.faceID.localized) { _, error in
                guard error == nil else {
                    // NÃO RECONHECEU O ROSTO E CLICOU EM CANCELAR
                    completion(.canEvaluateError)
                    return
                }
                // RECONHECEU O ROSTO
                completion(.canEvaluate)
            }
        } else {
            // NÃO TEM PERMISSÃO
            completion(.canNotEvaluate)
        }
    }
}
