//
//  HomeViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 12/05/23.
//

import Foundation
import UIKit

final class HomeViewModel {
    var result: [Int]?

    func generate(_ gameType: GameType) -> [Int] {
        result = []

        switch gameType {
        case .megasena:
            result = generateNumbers(total: 6, universe: 60)

        case .lotofacil:
            result = generateNumbers(total: 15, universe: 25)

        case .quina:
            result = generateNumbers(total: 5, universe: 80)

        case .lotomania:
            result = generateNumbers(total: 50, universe: 100)

        default:
            break
        }

        guard let result else { return [] }
        return result
    }

    private func generateNumbers(total: Int, universe: Int) -> [Int] {
        guard let result else { return [] }
        var myGame: [Int] = result

        while myGame.count < total {
            let randomNumber = Int.random(in: 1...universe)
            if !myGame.contains(randomNumber) {
                myGame.append(randomNumber)
            }
        }
        return myGame.sorted()
    }
}
