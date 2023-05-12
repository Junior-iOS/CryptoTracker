//
//  HomeView.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

class HomeView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Escolha seu jogo"
        return label
    }()
    
    private lazy var btnMegaSena: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(GameType.megasena.rawValue, for: .normal)
        button.addTarget(self, action: #selector(generatePressed), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 52/255, green: 125/255, blue: 57/255, alpha: 1)
        button.titleLabel?.textColor = .white
        button.tag = 0
        return button
    }()
    
    private lazy var btnLotoFacil: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(GameType.lotofacil.rawValue, for: .normal)
        button.addTarget(self, action: #selector(generatePressed), for: .touchUpInside)
        button.backgroundColor = .systemPurple
        button.titleLabel?.textColor = .white
        button.tag = 1
        return button
    }()
    
    private lazy var btnQuina: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(GameType.quina.rawValue, for: .normal)
        button.addTarget(self, action: #selector(generatePressed), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 25/255, green: 72/255, blue: 152/255, alpha: 1)
        button.titleLabel?.textColor = .white
        button.tag = 2
        return button
    }()
    
    private lazy var btnLotoMania: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(GameType.lotomania.rawValue, for: .normal)
        button.addTarget(self, action: #selector(generatePressed), for: .touchUpInside)
        button.backgroundColor = .systemOrange
        button.titleLabel?.textColor = .white
        button.tag = 3
        return button
    }()
    
    private lazy var btnMyGames: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Meus jogos", for: .normal)
        button.addTarget(self, action: #selector(myGamesPressed), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        return button
    }()
    
    private lazy var games = [btnMegaSena, btnLotoFacil, btnQuina, btnLotoMania, btnMyGames]
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: games)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addComponents()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

}

// MARK: - PRIVATE METHODS
private extension HomeView {
    @objc func generatePressed(_ sender: UIButton) {
//        delegate?.generateButtonPressed(sender)
    }
    
    @objc func myGamesPressed(_ sender: UIButton) {
//        let vc = SavedGamesViewController()
//
//        if loadedGames != nil && loadedIcons != nil {
//            guard let loadedGames = loadedGames, let loadedIcons = loadedIcons else { return }
//            vc.game = Game(icons: loadedIcons, loadedGames: loadedGames)
//        }
//        delegate?.savedGamesPressed(vc)
    }
    
    func addComponents() {
        
    }
}
