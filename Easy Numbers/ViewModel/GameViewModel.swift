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
}

final class GameViewModel: NSObject {
    weak var delegate: GameViewModelDelegate?
    var savedGames: [String]?

    func isSavedButtonHidden() {
        savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames")
        delegate?.hideSavedGamesButton(savedGames ?? [])
    }
    
    func route(from viewController: UIViewController, with savedGames: [String]) {
        let vc = SavedGamesViewController()
        vc.savedGames = savedGames
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
