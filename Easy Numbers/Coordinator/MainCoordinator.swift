//
//  MainCoordinator.swift
//  Easy Numbers
//
//  Created by NJ Development on 10/06/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func routeToInfoVC() {
        let infoVC = InfoViewController()
        navigationController.pushViewController(infoVC, animated: true)
    }
    
    func routeToGamesVC(with game: [Int], title: String) {
        let gameVC = GameViewController()
        gameVC.coordinator = self
        gameVC.game = game
        gameVC.gameTitle = title
        navigationController.pushViewController(gameVC, animated: true)
    }
    
    func routeToSavedGames(with savedGames: [String]) {
        let vc = SavedGamesViewController()
        vc.savedGames = savedGames
        navigationController.pushViewController(vc, animated: true)
    }
}
