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
    
    var linkedIn: String {
        self.object(forInfoDictionaryKey: "LINKED_IN") as? String ?? ""
    }
    
    var njEmail: String {
        self.object(forInfoDictionaryKey: "NJ_EMAIL") as? String ?? ""
    }
    
    var iTunesID: String {
        self.object(forInfoDictionaryKey: "ITUNES_ID") as? String ?? ""
    }
}
