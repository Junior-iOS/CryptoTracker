//
//  GameView.swift
//  Easy Numbers
//
//  Created by Junior Silva on 17/05/23.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func didPressGenerateGameAgain()
    func didPressCopyGame()
}

class GameView: UIView {
    lazy var gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressCopyGame)))
        label.isUserInteractionEnabled = true
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
    
    private let kLabelMargin: CGFloat = 20
    private let kButtonMargin: CGFloat = 40
    private let kButtonHeight: CGFloat = 50

    init(frame: CGRect, game: [Int]) {
        super.init(frame: frame)
        setGame(game)
        addComponents()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    func setGame(_ game: [Int]) {
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
            gameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: kLabelMargin),
            gameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            gameLabel.widthAnchor.constraint(equalToConstant: widthAnchor),
            gameLabel.bottomAnchor.constraint(equalTo: generateButton.topAnchor, constant: kLabelMargin),

            generateButton.centerXAnchor.constraint(equalTo: gameLabel.centerXAnchor),
            generateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -kButtonMargin),
            generateButton.widthAnchor.constraint(equalToConstant: widthAnchor),
            generateButton.heightAnchor.constraint(equalToConstant: kButtonHeight)
        ])
    }

    @objc private func generateAgain() {
        NJAnalytics.shared.trackEvent(name: .generateAgain)
        delegate?.didPressGenerateGameAgain()
    }

    @objc private func didPressCopyGame() {
        NJAnalytics.shared.trackEvent(name: .didCopy)
        
//        guard let result = gameLabel.text else { return }
//
//        let pasteboard = UIPasteboard.general
//        pasteboard.string = "\(result)"
//            .replacingOccurrences(of: "[", with: "")
//            .replacingOccurrences(of: "]", with: "")
//            .replacingOccurrences(of: ",", with: " ")
        
        delegate?.didPressCopyGame()
    }
}
