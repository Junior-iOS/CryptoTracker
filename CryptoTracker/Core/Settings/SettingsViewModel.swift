//
//  SettingsViewModel.swift
//  CryptoTracker
//
//  Created by NJ Development on 13/07/24.
//

import Foundation

final class SettingsViewModel {
    var coingeckoURL: URL {
        getURL(for: Constants.coingecko)
    }

    var linkedinURL: URL {
        getURL(for: Constants.linkedin)
    }

    var githubURL: URL {
        getURL(for: Constants.github)
    }

    private func getURL(for link: String) -> URL {
        guard let url = URL(string: link) else { return URL(string: Constants.google)! }
        return url
    }
}
