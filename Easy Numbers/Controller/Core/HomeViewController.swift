//
//  HomeViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

class HomeViewController: BaseViewController {
    // MARK: - Properties
    private lazy var btnMyGames: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Meus jogos", for: .normal)
        button.addTarget(self, action: #selector(myGamesPressed), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = kButtonHeight / 2
        button.isHidden = true
        return button
    }()

    private let homeView = HomeView()
    private var viewModel = HomeViewModel()
    
    weak var mainCoordinator: MainCoordinator?

    private let device = UIDevice.current.userInterfaceIdiom
    private let screenWidth = UIScreen.main.bounds.width

    private var myGames: [Int] = []
    private var gameTitle = ""
    private var backButtonBackgroundColor = UIColor.white
    
    private let kButtonHeight: CGFloat = 50
    private let kButtonMargin :CGFloat = 40

    // MARK: - Init & Life Cycle
    init(viewModel: HomeViewModel = HomeViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white

        guard let savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames") else { return }
        btnMyGames.isHidden = savedGames.isNotEmpty ? false : true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setup()
        NJAnalytics.shared.trackEvent(name: .didLoad)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = backButtonBackgroundColor
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.willRemoveSubview(homeView)
        view.willRemoveSubview(btnMyGames)
    }

    // MARK: - Methods
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle.fill"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didPressInfo))
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.title = Bundle.main.appName
        homeView.delegate = self

        addComponents()
    }

    private func addComponents() {
        view.addSubviews(homeView, btnMyGames)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        let homeWidth = device == .phone ? screenWidth - 40 : screenWidth / 2

        NSLayoutConstraint.activate([
            homeView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            homeView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            homeView.widthAnchor.constraint(equalToConstant: homeWidth),

            btnMyGames.centerXAnchor.constraint(equalTo: homeView.centerXAnchor),
            btnMyGames.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -kButtonMargin),
            btnMyGames.widthAnchor.constraint(equalTo: homeView.widthAnchor),
            btnMyGames.heightAnchor.constraint(equalToConstant: kButtonHeight)
        ])
    }

    @objc func myGamesPressed(_ sender: UIButton) {
        guard let savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames") else { return }
        viewModel.route(from: self, with: savedGames)
        NJAnalytics.shared.trackEvent(name: .didSave)
    }

    @objc func didPressInfo() {
        mainCoordinator?.routeToInfoVC()
        NJAnalytics.shared.trackEvent(name: .info)
    }
}

// MARK: - HomeView Delegate
extension HomeViewController: HomeViewDelegate {
    func didPressGenerateButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            myGames = viewModel.generate(.megasena)
            gameTitle = GameType.megasena.rawValue
            backButtonBackgroundColor = UIColor(red: 52 / 255, green: 125 / 255, blue: 57 / 255, alpha: 1)
            NJAnalytics.shared.trackEvent(name: .megasena)

        case 1:
            myGames = viewModel.generate(.lotofacil)
            gameTitle = GameType.lotofacil.rawValue
            backButtonBackgroundColor = .systemPurple
            NJAnalytics.shared.trackEvent(name: .lotofacil)

        case 2:
            myGames = viewModel.generate(.quina)
            gameTitle = GameType.quina.rawValue
            backButtonBackgroundColor = UIColor(red: 25 / 255, green: 72 / 255, blue: 152 / 255, alpha: 1)
            NJAnalytics.shared.trackEvent(name: .quina)

        case 3:
            myGames = viewModel.generate(.lotomania)
            gameTitle = GameType.lotomania.rawValue
            backButtonBackgroundColor = .systemOrange
            NJAnalytics.shared.trackEvent(name: .lotomania)
        default: break
        }

        let gameVC = GameViewController()
        gameVC.game = myGames
        gameVC.gameTitle = gameTitle
        navigationController?.pushViewController(gameVC, animated: true)
    }
}
