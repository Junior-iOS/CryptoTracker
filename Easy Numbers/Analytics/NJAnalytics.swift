//
//  NJAnalytics.swift
//  Easy Numbers
//
//  Created by NJ Development on 12/05/23.
//

import FirebaseAnalytics
import Foundation

final class NJAnalytics {
    static let shared = NJAnalytics()
    private init() {}

    enum Event: String {
        case didLoad = "Analytics_DidLoad"
        case didSave = "Analytics_DidSave"
        case didCopy = "Analytics_DidCopy"
        case didShare = "Analytics_DidShare"
        case generateAgain = "Analytics_GeneratedAgain"
        case savedGames = "Analytics_SavedGames"
        case info = "Analytics_Info"
        case settings = "Analytics_Settings"
        
        case megasena = "Analytics_Megasena"
        case lotofacil = "Analytics_Lotofacil"
        case quina = "Analytics_Quina"
        case lotomania = "Analytics_Lotomania"
        case timemania = "Analytics_Timemania"
    }
    
    enum Flow: String {
        case home = "Home"
        case games = "Games"
        case savedGames = "Saved Games"
        case info = "Info View"
        case settings = "Settings"
        case quickActions = "Quick Actions"
    }

    func trackEvent(name: Event, from flow: Flow, parameters: [String: Any]? = nil) {
        Analytics.logEvent(name.rawValue, parameters: parameters)
        
        print("\n======= 🔎 Tracking Interaction 🔍 =======\n")
        print("📂 Flow: \(flow.rawValue)")
        print("📘 Action: \(name.rawValue)")
        if parameters != nil {
            print("🗒️ Extra: \(String(describing: parameters))\n")
        }
        print("🕵🏻‍♂️ Tracked\n")
        print("======= 🔎 Tracking Ended 🔍 =======\n\n")
    }
}
