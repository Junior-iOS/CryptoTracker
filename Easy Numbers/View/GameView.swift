//
//  GameView.swift
//  Easy Numbers
//
//  Created by Junior Silva on 17/05/23.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func didPressGenerateGameAgain()
}

class GameView: UIView {

    lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private lazy var generateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Gerar novamente", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(generateAgain), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    weak var delegate: GameViewDelegate?
    private let device = UIDevice.current.userInterfaceIdiom
    private let screenWidth = UIScreen.main.bounds.width
    
    init(frame: CGRect, game: [Int]) {
        super.init(frame: frame)
        setGame(game)
        addComponents()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    public func setGame(_ game: [Int]) {
        DispatchQueue.main.async {
            self.gameLabel.text = "\(game)"
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: ",", with: " ")
        }
    }
    
    private func addComponents() {
        addSubviews(gameLabel, generateButton)
        let widthAnchor = device == .phone ? screenWidth - 40 : screenWidth / 2
        
        NSLayoutConstraint.activate([
            gameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            gameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            gameLabel.widthAnchor.constraint(equalToConstant: widthAnchor),
            gameLabel.bottomAnchor.constraint(equalTo: generateButton.topAnchor, constant: 20),
            
            generateButton.centerXAnchor.constraint(equalTo: gameLabel.centerXAnchor),
            generateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            generateButton.widthAnchor.constraint(equalToConstant: widthAnchor),
            generateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func generateAgain() {
        delegate?.didPressGenerateGameAgain()
    }
}
