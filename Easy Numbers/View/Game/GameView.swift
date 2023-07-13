//
//  GameView.swift
//  Easy Numbers
//
//  Created by Junior Silva on 17/05/23.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func didPressGenerateGameAgain()
    func didPressSavedGames(_ savedGames: [String])
    func didTapCopyGame()
}

class GameView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(GameViewCell.self, forCellWithReuseIdentifier: GameViewCell.identifier)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NJFont.demibold(ofSize: 25)
        label.textAlignment = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(copyGame))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var generateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Gerar novamente", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(generateAgain), for: .touchUpInside)
        button.layer.cornerRadius = .kButtonHeight / 2
        button.clipsToBounds = true
        return button
    }()
    
    lazy var savedGamesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Jogos salvos", for: .normal)
        button.addTarget(self, action: #selector(didPressSavedGamesButton), for: .touchUpInside)
        button.layer.cornerRadius = .kButtonHeight / 2
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [generateButton, savedGamesButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    weak var delegate: GameViewDelegate?
    
    private let device = UIDevice.current.userInterfaceIdiom
    private let screenWidth = UIScreen.main.bounds.width
    private var savedGames: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func addComponents() {
        addSubviews(collectionView, gameLabel, stackView)
        let widthAnchor = device == .phone ? screenWidth - 40 : screenWidth / 2
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .kLabelMargin),
            collectionView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -.kLabelMargin),
            
            gameLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            gameLabel.topAnchor.constraint(equalTo: collectionView.topAnchor),
            gameLabel.widthAnchor.constraint(equalTo: collectionView.widthAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -.kButtonMargin),
            
            generateButton.widthAnchor.constraint(equalToConstant: widthAnchor),
            generateButton.heightAnchor.constraint(equalToConstant: .kButtonHeight)
        ])
        
        NSLayoutConstraint.activate(centerCollectionOnIpad())
    }
    
    private func centerCollectionOnIpad() -> [NSLayoutConstraint] {
        if device == .phone {
            return [collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: .kLabelMargin),
                    collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.kLabelMargin)]
        } else {
            return [collectionView.topAnchor.constraint(equalTo: topAnchor, constant: .kMarginOnIpad),
                    collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    collectionView.widthAnchor.constraint(equalToConstant: screenWidth / 2)
            ]
        }
    }
    
    @objc private func copyGame() {
        delegate?.didTapCopyGame()
    }
    
    @objc private func didPressSavedGamesButton() {
        savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames")
        
        NJAnalytics.shared.trackEvent(name: .savedGames, from: .games)
        delegate?.didPressSavedGames(savedGames ?? [])
    }
    
    @objc private func generateAgain() {
        NJAnalytics.shared.trackEvent(name: .generateAgain, from: .games)
        delegate?.didPressGenerateGameAgain()
    }
}

fileprivate extension CGFloat {
    static let kLabelMargin: CGFloat = 20
    static let kButtonMargin: CGFloat = 40
    static let kButtonHeight: CGFloat = 50
    static let kMarginOnIpad: CGFloat = 200
}
