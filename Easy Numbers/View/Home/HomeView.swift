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
    case timemania = "Timemania"
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
        createButton(title: GameType.megasena.rawValue,
                     backgroundColor: NJColor.megasena,
                     tag: 0)
    }()

    private lazy var btnLotoFacil: UIButton = {
        createButton(title: GameType.lotofacil.rawValue,
                     backgroundColor: NJColor.lotofacil,
                     tag: 1)
    }()

    private lazy var btnQuina: UIButton = {
        createButton(title: GameType.quina.rawValue,
                     backgroundColor: NJColor.quina,
                     tag: 2)
    }()

    private lazy var btnLotoMania: UIButton = {
        createButton(title: GameType.lotomania.rawValue,
                     backgroundColor: NJColor.lotomania,
                     tag: 3)
    }()
    
    private lazy var btnTimeMania: UIButton = {
        createButton(title: GameType.timemania.rawValue,
                     titleColor: NJColor.megasena,
                     backgroundColor: NJColor.timemania,
                     tag: 4)
    }()

    private lazy var games = [btnMegaSena, btnLotoFacil, btnQuina, btnLotoMania, btnTimeMania]

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
            $0.layer.cornerRadius = 25
            $0.clipsToBounds = true
        })
    }
    
    private func createButton(title: String,
                              titleColor: UIColor = .white,
                              backgroundColor: UIColor,
                              tag: Int) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generatePressed), for: .touchUpInside)
        button.backgroundColor = backgroundColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.tag = tag
        return button
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
