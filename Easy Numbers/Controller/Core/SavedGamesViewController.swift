//
//  SavedGamesViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 22/05/23.
//

import UIKit

class SavedGamesViewController: UIViewController {

    var savedGames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
        
        savedGames.forEach({ print("SAVED GAMES: ", $0) })
    }
    
}
