//
//  NJAnalytics.swift
//  Easy Numbers
//
//  Created by NJ Development on 12/05/23.
//

import FirebaseAnalytics
import Foundation
import UIKit

final class NJAnalytics {
    static let shared = NJAnalytics()
    private init() {}

    enum Event: String {
        case didLoad = "Analytics_DidLoad"
        case didSave = "Analytics_DidSave"
        case didCopy = "Analytics_DidCopy"
        case generateAgain = "Analytics_GeneratedAgain"
        case savedGames = "Analytics_SavedGames"
        case info = "Analytics_Info"
        case megasena = "Analytics_Megasena"
        case lotofacil = "Analytics_Lotofacil"
        case quina = "Analytics_Quina"
        case lotomania = "Analytics_Lotomania"
    }

    func trackEvent(name: Event, parameters: [String: Any]? = nil) {
        Analytics.logEvent(name.rawValue, parameters: parameters)
    }
}
