//
//  SettingsViewModel.swift
//  CryptoTracker
//
//  Created by NJ Development on 13/07/24.
//

import Foundation

final class SettingsViewModel {
    var coingeckoURL: URL {
        return getURL(for: Constants.coingecko)
    }
    
    var linkedinURL: URL {
        return getURL(for: Constants.linkedin)
    }
    
    var githubURL: URL {
        return getURL(for: Constants.github)
    }
    
    private func getURL(for link: String) -> URL {
        guard let url = URL(string: link) else { return URL(string: Constants.google)! }
        return url
    }
}
