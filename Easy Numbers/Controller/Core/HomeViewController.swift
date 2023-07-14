//
//  HomeViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import OnboardingKit
import UIKit

class HomeViewController: BaseViewController {
    // MARK: - Properties
    private lazy var btnMyGames: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(viewModel.myGamesButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(myGamesPressed), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = kButtonHeight / 2
        button.isHidden = true
        return button
    }()

    private let homeView = HomeView()
    private var viewModel: HomeViewModel

    weak var coordinator: MainCoordinator?

    private let device = UIDevice.current.userInterfaceIdiom
    private let screenWidth = UIScreen.main.bounds.width

    private var myGames: [Int] = []
    private var gameTitle = ""
    private var backButtonBackgroundColor = UIColor.white

    private let kButtonHeight: CGFloat = 50
    private let kButtonMargin: CGFloat = 40

    // MARK: - Init & Life Cycle
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        btnMyGames.isEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        updateFlag()
        checkRemoteConfig()

        viewModel.delegate = self
        NJAnalytics.shared.trackEvent(name: .didLoad, from: .home)
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
    private func setup() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = viewModel.navTitle
        setupNavigation(actionFor: #selector(didPressInfo), actionFor: #selector(didPressSettings))
        
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
        btnMyGames.isEnabled = false
        coordinator?.routeToSavedGames(with: savedGames)

        NJAnalytics.shared.trackEvent(name: .didSave, from: .games)
    }

    @objc private func didPressInfo() {
        coordinator?.routeToInfoVC()
        NJAnalytics.shared.trackEvent(name: .info, from: .home)
    }
    
    @objc private func didPressSettings() {
        coordinator?.routeToSettingsVC()
        // MARK: - TO DO: Analytics
    }

    private func updateFlag() {
        if !UserDefaults.standard.bool(forKey: "isOnboardingSeen") {
            viewModel.presentOnboardingKit()
        }
    }

    private func checkRemoteConfig() {
        viewModel.checkRemoteConfig()
    }
}

// MARK: - HomeView Delegate
extension HomeViewController: HomeViewDelegate {
    func didPressGenerateButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            myGames = viewModel.generate(.megasena)
            gameTitle = GameType.megasena.rawValue
            backButtonBackgroundColor = NJColor.megasena
            NJAnalytics.shared.trackEvent(name: .megasena, from: .games)

        case 1:
            myGames = viewModel.generate(.lotofacil)
            gameTitle = GameType.lotofacil.rawValue
            backButtonBackgroundColor = NJColor.lotofacil
            NJAnalytics.shared.trackEvent(name: .lotofacil, from: .games)

        case 2:
            myGames = viewModel.generate(.quina)
            gameTitle = GameType.quina.rawValue
            backButtonBackgroundColor = NJColor.navColorOnQuina
            NJAnalytics.shared.trackEvent(name: .quina, from: .games)

        case 3:
            myGames = viewModel.generate(.lotomania)
            gameTitle = GameType.lotomania.rawValue
            backButtonBackgroundColor = NJColor.lotomania
            NJAnalytics.shared.trackEvent(name: .lotomania, from: .games)
        default:
            myGames = viewModel.generate(.timemania)
            gameTitle = GameType.timemania.rawValue
            backButtonBackgroundColor = NJColor.timemania
            NJAnalytics.shared.trackEvent(name: .timemania, from: .games)
        }

        coordinator?.routeToGamesVC(with: myGames, title: gameTitle)
    }
}

// MARK: - HomeViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
    func handleRemoteConfig(with value: Bool) {
        if value {
            coordinator?.routeToOutOfOrderView()
            hideNavigationBar(value)
        }
    }
    
    func handlePresentOnboarding() {
        viewModel.onboardingKit?.launchOnboarding(controller: self)
    }

    func didTapNextButton() {}

    func didTapGetStarted() {
        UserDefaults.standard.set(true, forKey: "isOnboardingSeen")
        viewModel.onboardingKit?.dismissOnboarding()
    }
}
