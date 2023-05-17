//
//  GameViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 16/05/23.
//

import UIKit

class GameViewController: BaseViewController {
    
    public var game: [Int]?
    private lazy var gameView = GameView(frame: .zero, game: game ?? [])
    private let homeViewModel = HomeViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = gameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        view.backgroundColor = .systemBackground
    }
    
    private func generateGame(_ type: GameType) {
        self.game = homeViewModel.generate(game: type)
        guard let game = game else { return }
        self.gameView.setGame(game)
    }
}

extension GameViewController: GameViewDelegate {
    func didPressGenerateGameAgain() {
        guard let game = game else { return }
        switch game.count {
        case 5: generateGame(.quina)
        case 6: generateGame(.megasena)
        case 15: generateGame(.lotofacil)
        case 50: generateGame(.lotomania)
        default: break
        }
    }
}
