//
//  SavedGamesViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 24/05/23.
//

import Foundation
import UIKit

final class SavedGamesViewModel: NSObject {
    func setGameName(_ savedGame: String, completion: (String) -> ()) {
        if savedGame.count <= 20 {
            completion("Quina")
        } else if savedGame.count > 20 && savedGame.count <= 24 {
            completion("Mega-sena")
        } else if savedGame.count > 24 && savedGame.count <= 60 {
            completion("Loto Fácil")
        } else {
            completion("Lotomania")
        }
    }
}
