//
//  HomeViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 12/05/23.
//

import Foundation
import UIKit
import FirebaseRemoteConfig

// MARK: - Protocols

protocol HomeViewModelDelegate: AnyObject {
    func handleRemoteConfigUpdate(with value: Bool)
}

protocol GenerateNumbers: AnyObject {
    func generateNumbers(total: Int, universe: Int) -> [Int]
}

/// ViewModel responsible for managing home screen business logic and game generation
final class HomeViewModel {
    
    // MARK: - Types
    
    private enum Constants {
        static let fetchExpirationDuration: TimeInterval = 0
    }
    
    // MARK: - Properties
    
    weak var delegate: HomeViewModelDelegate?
    
    let navTitle = Bundle.main.appName
    let myGamesButtonTitle = LocalizableStrings.homeSavedGames.localized
    
    // MARK: - Private Properties
    
    private let remoteConfig: RemoteConfig = {
        let config = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = Constants.fetchExpirationDuration
        config.configSettings = settings
        return config
    }()
    
    // MARK: - Public Methods
    
    /// Generates random numbers based on the selected game type
    /// - Parameter gameType: The type of lottery game
    /// - Returns: Array of randomly generated numbers according to game rules
    func generate(_ gameType: GameType) -> [Int] {
        let gameRules = GameRules(for: gameType)
        return generateNumbers(total: gameRules.totalNumbers,
                             universe: gameRules.universeRange)
    }
    
    /// Fetches and applies remote configuration settings
    func checkRemoteConfig() {
        setupDefaultRemoteConfig()
        fetchRemoteConfig()
    }
    
    // MARK: - Private Methods
    
    private func setupDefaultRemoteConfig() {
        let defaults: [String: NSObject] = [
            RemoteConfigValue.newUI.rawValue: false as NSObject
        ]
        remoteConfig.setDefaults(defaults)
    }
    
    private func fetchRemoteConfig() {
        remoteConfig.fetch(withExpirationDuration: Constants.fetchExpirationDuration) { [weak self] status, error in
            guard let self, status == .success, error == nil else { return }
            activateRemoteConfig()
        }
    }
    
    private func activateRemoteConfig() {
        remoteConfig.activate { [weak self] _, error in
            guard let self, error == nil else { return }
            
            let value = remoteConfig.configValue(forKey: RemoteConfigValue.newUI.rawValue).boolValue
            updateUI(value)
        }
    }
    
    private func updateUI(_ value: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            delegate?.handleRemoteConfigUpdate(with: value)
        }
    }
}

// MARK: - Generate Numbers Protocol

extension HomeViewModel: GenerateNumbers {
    func generateNumbers(total: Int, universe: Int) -> [Int] {
        var numbers = Set<Int>()
        
        while numbers.count < total {
            numbers.insert(Int.random(in: 1...universe))
        }
        
        return Array(numbers).sorted()
    }
}
