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
        homeViewController.mainCoordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func routeToInfoVC() {
        let infoVC = InfoViewController()
        navigationController.pushViewController(infoVC, animated: true)
    }
}
