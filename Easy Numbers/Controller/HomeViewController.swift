//
//  HomeViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

enum GameType: String {
    case megasena = "Megasena"
    case lotofacil = "LotoFácil"
    case quina = "Quina"
    case lotomania = "LotoMania"
    case unknown = ""
}

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        NJAnalytics.shared.trackEvent(name: "Analytics_DidLoad")
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.title = Bundle.main.appName
    }
}

