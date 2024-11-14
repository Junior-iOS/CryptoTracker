//
//  HomeViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

/// A view controller that manages the main home screen of the lottery number generator app.
/// Displays game type options and handles navigation to other screens.
final class HomeViewController: BaseViewController {
    // MARK: - UI Components
    
    private lazy var savedGamesButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration?.title = viewModel.myGamesButtonTitle
        button.configuration?.cornerStyle = .large
        button.configuration?.baseBackgroundColor = .systemBlue
        button.addTarget(self, action: #selector(savedGamesPressed), for: .primaryActionTriggered)
        button.isHidden = true
        return button
    }()

    private let homeView = HomeView()
    private let viewModel: HomeViewModel
    weak var coordinator: MainCoordinator?

    // MARK: - Layout Constants
    
    private enum LayoutMetrics {
        static let buttonHeight: CGFloat = 50
        static let buttonMargin: CGFloat = 40
        static let minimumTapSize: CGFloat = 44
    }

    // MARK: - Properties
    
    private var deviceType: UIUserInterfaceIdiom {
        UIDevice.current.userInterfaceIdiom
    }
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    // MARK: - Initialization

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        checkRemoteConfiguration()
        
        viewModel.delegate = self
        NJAnalytics.shared.trackEvent(name: .didLoad, from: .home)
        
        performBiometricAuthentication()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        updateSavedGamesButtonVisibility()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        restoreNavigationBarTint()
    }

    // MARK: - Private Methods
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.navTitle
        setupNavigationItems()
        
        homeView.delegate = self
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubviews(homeView, savedGamesButton)
        homeView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentWidth = deviceType == .phone ? screenWidth - 40 : screenWidth / 2
        
        NSLayoutConstraint.activate([
            homeView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            homeView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            homeView.widthAnchor.constraint(equalToConstant: contentWidth),
            
            savedGamesButton.centerXAnchor.constraint(equalTo: homeView.centerXAnchor),
            savedGamesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutMetrics.buttonMargin),
            savedGamesButton.widthAnchor.constraint(equalTo: homeView.widthAnchor),
            savedGamesButton.heightAnchor.constraint(equalToConstant: LayoutMetrics.buttonHeight)
        ])
    }

    private func setupNavigationItems() {
        setupNavigation(
            actionFor: #selector(settingsButtonTapped),
            actionFor: #selector(infoButtonTapped)
        )
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func restoreNavigationBarTint() {
        navigationController?.navigationBar.tintColor = .link
    }
    
    private func updateSavedGamesButtonVisibility() {
        let savedGames = GameManager.shared.retrieveGames()
        savedGamesButton.isHidden = savedGames.isEmpty
        savedGamesButton.isEnabled = true
    }

    // MARK: - Action Methods
    
    @objc private func savedGamesPressed(_ sender: UIButton) {
        let savedGames = GameManager.shared.retrieveGames()
        sender.isEnabled = false
        NJAnalytics.shared.trackEvent(name: .didSave, from: .games)
        coordinator?.routeToSavedGames(with: savedGames)
    }

    @objc private func infoButtonTapped() {
        coordinator?.routeToInfoVC()
        NJAnalytics.shared.trackEvent(name: .info, from: .home)
    }

    @objc private func settingsButtonTapped() {
        coordinator?.routeToSettingsVC()
        NJAnalytics.shared.trackEvent(name: .settings, from: .home)
    }
    
    private func checkRemoteConfiguration() {
        viewModel.checkRemoteConfig()
    }
    
    private func performBiometricAuthentication() {
        guard let coordinator else { return }
        checkforFaceID(coordinator)
    }
}

// MARK: - HomeView Delegate
extension HomeViewController: HomeViewDelegate {
    func didPressGenerateButton(_ sender: UIButton) {
        guard let gameType = GameType(rawValue: sender.tag) else { return }
        let numbers = viewModel.generate(gameType)
        coordinator?.routeToGamesVC(with: numbers, title: gameType.title)
    }
}

// MARK: - HomeViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
    func handleRemoteConfigUpdate(with value: Bool) {
        if value {
            coordinator?.routeToOutOfOrderView()
            hideNavigationBar(value)
        }
    }
}
