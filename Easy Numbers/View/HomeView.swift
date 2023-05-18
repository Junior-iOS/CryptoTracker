//
//  HomeView.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

// MARK: - Protocols
protocol HomeViewDelegate: AnyObject {
    func didPressGenerateButton(_ sender: UIButton)
}

// MARK: - Enum
enum GameType: String {
    case megasena = "Megasena"
    case lotofacil = "LotoFácil"
    case quina = "Quina"
    case lotomania = "LotoMania"
    case unknown = ""
}

class HomeView: UIView {
    // MARK: - Properties
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

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
        button.backgroundColor = UIColor(red: 52 / 255, green: 125 / 255, blue: 57 / 255, alpha: 1)
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
        button.backgroundColor = UIColor(red: 25 / 255, green: 72 / 255, blue: 152 / 255, alpha: 1)
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

    private lazy var games = [btnMegaSena, btnLotoFacil, btnQuina, btnLotoMania]

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: games)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()

    weak var delegate: HomeViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods
    private func setViewsRoundCorners() {
        games.forEach({
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        })
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setViewsRoundCorners()
    }
}

// MARK: - PRIVATE METHODS
private extension HomeView {
    @objc func generatePressed(_ sender: UIButton) {
        delegate?.didPressGenerateButton(sender)
    }

    func addComponents() {
        addSubview(contentView)
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            btnMegaSena.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
