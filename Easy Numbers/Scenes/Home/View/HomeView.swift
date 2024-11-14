//
//  HomeView.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

// MARK: - HomeView Delegate

protocol HomeViewDelegate: AnyObject {
    func didPressGenerateButton(_ sender: UIButton)
}

/// Main view for the home screen that displays lottery game type options
final class HomeView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: HomeViewDelegate?
    
    // MARK: - UI Components
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = LayoutMetrics.stackSpacing
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Layout Constants
    
    private enum LayoutMetrics {
        static let stackSpacing: CGFloat = 12
        static let buttonHeight: CGFloat = 50
        static let contentPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setViewsRoundCorners()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        backgroundColor = .clear
        addComponents()
        setupConstraints()
        createGameButtons()
    }
    
    private func addComponents() {
        addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutMetrics.contentPadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutMetrics.contentPadding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutMetrics.contentPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutMetrics.contentPadding)
        ])
    }
    
    private func createGameButtons() {
        let games: [(type: GameType, title: String, color: UIColor)] = [
            (.quina, GameType.quina.title, GameType.quina.color),
            (.megasena, GameType.megasena.title, GameType.megasena.color),
            (.timemania, GameType.timemania.title, GameType.timemania.color),
            (.lotofacil, GameType.lotofacil.title, GameType.lotofacil.color),
            (.lotomania, GameType.lotomania.title, GameType.lotomania.color)
        ]
        
        games.forEach { game in
            let button = createButton(
                title: game.title,
                backgroundColor: game.color,
                tag: game.type.rawValue
            )
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(title: String,
                            titleColor: UIColor = .white,
                            backgroundColor: UIColor,
                            tag: Int) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseForegroundColor = titleColor
        configuration.baseBackgroundColor = backgroundColor
        configuration.cornerStyle = .large
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generatePressed), for: .primaryActionTriggered)
        button.tag = tag
        
        button.heightAnchor.constraint(equalToConstant: LayoutMetrics.buttonHeight).isActive = true
        
        return button
    }
    
    private func setViewsRoundCorners() {
        stackView.arrangedSubviews.forEach { button in
            button.layer.cornerRadius = LayoutMetrics.cornerRadius
            button.clipsToBounds = true
        }
    }
    
    // MARK: - Actions
    
    @objc private func generatePressed(_ sender: UIButton) {
        delegate?.didPressGenerateButton(sender)
    }
}
