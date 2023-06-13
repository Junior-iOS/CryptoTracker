//
//  Extension+Bundle.swift
//  Apple Music
//
//  Created by NJ Development on 11/05/23.
//

import Foundation

extension Bundle {
    var appName: String {
        self.object(forInfoDictionaryKey: "APP_NAME") as? String ?? ""
    }
    
    var savedGamestitle: String {
        self.object(forInfoDictionaryKey: "SAVED_GAMES_TITLE") as? String ?? ""
    }
    
    var resultsURL: String {
        self.object(forInfoDictionaryKey: "RESULTS_URL") as? String ?? ""
    }
}
