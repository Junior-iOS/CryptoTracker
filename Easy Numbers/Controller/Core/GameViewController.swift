//
//  GameViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 16/05/23.
//

import UIKit

class GameViewController: BaseViewController {
   
    private lazy var gameView = GameView(frame: .zero, game: game ?? [])
    private let homeViewModel = HomeViewModel()
    
    var game: [Int]?
    var gameTitle: String?

    override func loadView() {
        super.loadView()
        self.view = gameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        navigationItem.title = gameTitle
        view.backgroundColor = .systemBackground
    }

    private func generateGame(_ type: GameType) {
        self.game = homeViewModel.generate(game: type)
        guard let game else { return }
        self.gameView.setGame(game)
    }
}

extension GameViewController: GameViewDelegate {
    func didPressGenerateGameAgain() {
        guard let game else { return }
        switch game.count {
        case 5: generateGame(.quina)
        case 6: generateGame(.megasena)
        case 15: generateGame(.lotofacil)
        case 50: generateGame(.lotomania)
        default: break
        }
    }
    
    func didPressCopyGame() {
        guard let result = game, let title = gameTitle else { return }

        let pasteboard = UIPasteboard.general
        pasteboard.string = "\(String(describing: title)) 🤞🏻\n\(result)"
            .replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: ",", with: " ")
    }
}
