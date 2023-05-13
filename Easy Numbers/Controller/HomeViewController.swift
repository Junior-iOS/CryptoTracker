//
//  HomeViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var btnMyGames: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Meus jogos", for: .normal)
        button.addTarget(self, action: #selector(myGamesPressed), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let homeView = HomeView()
    private var viewModel = HomeViewModel()
    private let device = UIDevice.current.userInterfaceIdiom
    private let screenWidth = UIScreen.main.bounds.width
    
    // MARK: - Init & Life Cycle
    init(viewModel: HomeViewModel = HomeViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        NJAnalytics.shared.trackEvent(name: .didLoad)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientColor()
    }

    // MARK: - Methods
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
            btnMyGames.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            btnMyGames.widthAnchor.constraint(equalTo: homeView.widthAnchor),
            btnMyGames.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func myGamesPressed(_ sender: UIButton) {
//        let vc = SavedGamesViewController()
//
//        if loadedGames != nil && loadedIcons != nil {
//            guard let loadedGames = loadedGames, let loadedIcons = loadedIcons else { return }
//            vc.game = Game(icons: loadedIcons, loadedGames: loadedGames)
//        }
        viewModel.didPressMySavedGames()
    }
}

// MARK: - HomeView Delegate
extension HomeViewController: HomeViewDelegate {
    func didPressGenerateButton(_ sender: UIButton) {
        switch sender.tag {
        case 0: NJAnalytics.shared.trackEvent(name: .megasena)
        case 1: NJAnalytics.shared.trackEvent(name: .lotofacil)
        case 2: NJAnalytics.shared.trackEvent(name: .quina)
        case 3: NJAnalytics.shared.trackEvent(name: .lotomania)
        default: break
        }
    }
}
