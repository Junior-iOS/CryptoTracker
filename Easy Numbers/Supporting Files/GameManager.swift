//
//  GameManager.swift
//  Easy Numbers
//
//  Created by NJ Development on 23/11/23.
//

import Foundation

class GameManager {
    static let shared = GameManager()
    
    private let userdefaults = UserDefaults.standard
    private let gamesKey = "SavedGames"
    
    func saveGames(_ games: [String]) {
        userdefaults.setValue(games, forKey: gamesKey)
    }
    
    func retrieveGames() -> [String] {
        if let games = userdefaults.array(forKey: gamesKey) as? [String] {
            return games
        }
        return []
    }
    
    func addGame(_ game: String) {
        var games = retrieveGames()
        games.append(game)
        saveGames(games)
    }
    
    func deleteGame(at index: Int) {
        var games = retrieveGames()
        if index < games.count {
            games.remove(at: index)
            saveGames(games)
        }
    }
    
    func updateGame(at index: Int, with newGame: String) {
        var games = retrieveGames()
        if index < games.count {
            games[index] = newGame
            saveGames(games)
        }
    }
}
