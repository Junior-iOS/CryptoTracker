//
//  MainCoordinator.swift
//  Easy Numbers
//
//  Created by NJ Development on 10/06/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController = UINavigationController()

    func start() {
        let viewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: viewModel)
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }

    func routeToInfoVC() {
        let viewModel = InfoViewModel()
        let infoVC = InfoViewController(viewModel: viewModel)
        navigationController.pushViewController(infoVC, animated: true)
    }
    
    func routeToSettingsVC() {
        let viewModel = SettingsViewModel()
        let settingsVC = SettingsViewController(viewModel: viewModel)
        navigationController.pushViewController(settingsVC, animated: true)
    }

    func routeToGamesVC(with game: [Int], title: String) {
        let viewModel = GameViewModel()
        viewModel.game = game
        viewModel.gameTitle = title
        
        let gameVC = GameViewController(viewModel: viewModel)
        gameVC.coordinator = self
        navigationController.pushViewController(gameVC, animated: true)
    }

    func routeToSavedGames(with savedGames: [String]) {
        let viewModel = SavedGamesViewModel()
        viewModel.savedGames = savedGames
        
        let vc = SavedGamesViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func routeToOutOfOrderView() {
        let vc = OutOfOrderViewController()
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.pushViewController(vc, animated: true)
    }
    
    func routeCheckFaceID() {
        let vc = CheckFaceIDViewController(self)
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.pushViewController(vc, animated: true)
    }
}
