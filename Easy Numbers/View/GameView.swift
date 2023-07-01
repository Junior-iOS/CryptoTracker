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

    private lazy var generateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Gerar novamente", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(generateAgain), for: .touchUpInside)
        button.layer.cornerRadius = kButtonHeight / 2
        button.clipsToBounds = true
        return button
    }()

    lazy var savedGamesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Jogos salvos", for: .normal)
        button.addTarget(self, action: #selector(didPressSavedGamesButton), for: .touchUpInside)
        button.layer.cornerRadius = kButtonHeight / 2
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

    private let kLabelMargin: CGFloat = 20
    private let kButtonMargin: CGFloat = 40
    private let kButtonHeight: CGFloat = 50

    private var savedGames: [String]?

    init(frame: CGRect, game: [Int]) {
        super.init(frame: frame)
        addComponents()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func addComponents() {
        addSubviews(collectionView, stackView)
        let widthAnchor = device == .phone ? screenWidth - 40 : screenWidth / 2

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: kLabelMargin),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: kLabelMargin),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -kLabelMargin),
            collectionView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -kLabelMargin),

            stackView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -kButtonMargin),

            generateButton.widthAnchor.constraint(equalToConstant: widthAnchor),
            generateButton.heightAnchor.constraint(equalToConstant: kButtonHeight)
        ])
    }

    @objc private func didPressSavedGamesButton() {
        savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames")

        NJAnalytics.shared.trackEvent(name: .savedGames)
        delegate?.didPressSavedGames(savedGames ?? [])
    }

    @objc private func generateAgain() {
        NJAnalytics.shared.trackEvent(name: .generateAgain)
        delegate?.didPressGenerateGameAgain()
    }
}
