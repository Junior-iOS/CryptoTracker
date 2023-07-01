//
//  GameViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 18/05/23.
//

import Foundation
import UIKit

protocol GameViewModelDelegate: AnyObject {
    func hideSavedGamesButton(_ game: [String])
    func didPressCopyGame()
    func reloadCollection()
}

final class GameViewModel: NSObject {
    weak var delegate: GameViewModelDelegate?
    var savedGames: [String]?
    
    var game: [Int]? {
        didSet { self.delegate?.reloadCollection() }
    }
    
    var numberOfItemsInSection: Int {
        game?.count ?? 0
    }

    func isSavedButtonHidden() {
        savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames")
        delegate?.hideSavedGamesButton(savedGames ?? [])
    }
    
    func didPressCopyGame() {
        NJAnalytics.shared.trackEvent(name: .didCopy)
        delegate?.didPressCopyGame()
    }
}
