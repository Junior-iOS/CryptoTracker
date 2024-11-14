//
//  GameRules.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/11/24.
//

struct GameRules {
    let totalNumbers: Int
    let universeRange: Int
    
    init(for gameType: GameType) {
        switch gameType {
        case .megasena:
            totalNumbers = 6
            universeRange = 60
        case .lotofacil:
            totalNumbers = 15
            universeRange = 25
        case .quina:
            totalNumbers = 5
            universeRange = 80
        case .lotomania:
            totalNumbers = 50
            universeRange = 100
        case .timemania:
            totalNumbers = 10
            universeRange = 80
        }
    }
}
