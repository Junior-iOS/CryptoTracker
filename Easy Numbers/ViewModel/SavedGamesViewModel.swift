//
//  SavedGamesViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 24/05/23.
//

import Foundation
import UIKit

final class SavedGamesViewModel: NSObject {
    var savedGames: [String] = []
    var filteredGames: [String] = []
    
    var numberOfRowsInSection: Int {
        filteredGames.count
    }
    
    func setGameName(_ savedGame: String, completion: (String) -> Void) {
        if savedGame.count <= 15 {
            completion("Quina")
        } else if savedGame.count > 15 && savedGame.count <= 24 {
            completion("Mega-sena")
        } else if savedGame.count > 24 && savedGame.count <= 40 {
            completion("Timemania")
        } else if savedGame.count > 40 && savedGame.count <= 60 {
            completion("Loto Fácil")
        } else {
            completion("Lotomania")
        }
    }
    
    func updateFilteredArray() {
        filteredGames = savedGames.sorted(by: { $0.count < $1.count })
    }
}
