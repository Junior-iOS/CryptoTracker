//
//  NJAnalytics.swift
//  Easy Numbers
//
//  Created by NJ Development on 12/05/23.
//

import Foundation
import FirebaseAnalytics
import FirebaseAnalyticsSwift
import UIKit

final class NJAnalytics {
    static let shared = NJAnalytics()
    private init(){}
    
    func trackEvent(name: String, parameters: [String: Any]? = nil) {
        Analytics.logEvent(name, parameters: parameters)
    }
}
