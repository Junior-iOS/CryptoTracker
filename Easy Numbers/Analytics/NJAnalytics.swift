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
    
    enum Event: String {
        case didLoad = "Analytics_DidLoad"
    }
    
    func trackEvent(name: Event, parameters: [String: Any]? = nil) {
        Analytics.logEvent(name.rawValue, parameters: parameters)
    }
}
